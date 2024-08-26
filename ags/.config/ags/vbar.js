import App from 'resource:///com/github/Aylur/ags/app.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';


// Constants
const gridSize = 8;
const gaps = gridSize;


const Clock = () => Widget.Box({
	class_name: "widget-box",
	height_request: 72,
	vertical: true,
	hpack: "fill",
	child: Time()
})

const Time = () => Widget.Box({
	vertical: true,
	children: [
		Widget.Box({
			vexpand: true,
			hpack: "fill",
			height_request: 64,
			child: Widget.Label({
				hexpand: true,
				hpack: "center",
				class_name: "big-time",
				setup: self => self
				.poll(1000, self => Utils.execAsync(['date', '+%H\n%M'])
					.then(date => self.label = date))
			})
		}),
		Widget.Label({
			class_name: "small-time inverted",
			height_request: 16,
			setup: self => self
			.poll(1000, self => Utils.execAsync(['date', '+%S'])
				.then(date => self.label = date))
		}),
	]
});

const Date = () => Widget.Box({
	class_name: "widget-box padded-box",
	height_request: 64,
	vertical: true,
	hpack: "fill",
	child: Widget.Box({
		hexpand: true,
		hpack: "center",
		child: date(),
	})
})

const date = () => 
	Widget.Label({
		class_name: "clock-big",
		justification: "center",
		setup: self => self
		.poll(10000, self => Utils.execAsync(['date', '+%a\n%-e\n%b'])
			.then(date => self.label = date)),
	});


const wkspcValues = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];
const Workspaces = () => Widget.Box({
	class_name: 'workspaces',
	vertical: true,
	spacing: gaps,
	hpack: "fill",
	children:
	Hyprland.bind("workspaces").as((ws) =>
		ws
		// remove scratchpads from the list
		.filter(({ id }) => id > 0)
		// sort by id
		.sort((a, b) => a.id - b.id)
		.map(({ id }) =>
			Widget.Box({
				height_request: 24,
				hpack: "fill",
				class_name:
				Hyprland.active.workspace.bind("id").as((i) =>
					`${i === id ? "focused" : "workspace"}`),
				//on_clicked: () => Hyprland.messageAsync(`dispatch workspace ${id}`),
				child:
				Widget.Fixed({
					width_request: 3,
					height_request: 24,
					hpack: "end",
					hexpand: true,
					child:
					Widget.Label({
						label: `${id}`,
					}),
				})
			})
		)
	),
});

const CPUWidget = () => Widget.Box({
	class_name: "widget-box padded-box",
	height_request: 48,
	vertical: true,
	hpack: "fill",
	child: CPUPercent()
});

const CPUPercent = () => Widget.Label({
	hexpand: true,
	hpack: "center",
	justification: "center",
	setup: self => self.poll(1000,
		self => Utils.execAsync(`${App.configDir}/scripts/cpu-usage.sh`)
		.then(cpuuse => self.label = `CPU\n${cpuuse}`)
		.catch(err => print(err))
	),
})


const BatWidget = () => Widget.Box({
	vertical: true,
	children: [
		Widget.Box({
			height_request: 48,
			hpack: "fill",
			class_name: "widget-box padded-box",
			child: Widget.Box({
				hexpand: true,
				hpack: "center",
				child: BatteryPercent()
			})
		}),
		BatteryIndicator(),
	]
});

const BatteryPercent = () =>
	Widget.Label({
		justification: "center"
	}).hook(Battery, label => {
		label.label = `BAT\n${Battery.percent}`
		label.visible = Battery.available
	}, 'changed');

const coloursMix = function(color_1, color_2, weight) {
	function d2h(d) { return d.toString(16); }
	function h2d(h) { return parseInt(h, 16); }
	weight = (typeof(weight) !== 'undefined') ? weight : 50;
	var color = "#";
	for(var i = 0; i <= 5; i += 2) {
		var v1 = h2d(color_1.substr(i, 2)),
		v2 = h2d(color_2.substr(i, 2)),
		val = d2h(Math.floor(v2 + (v1 - v2) * (weight / 100.0))); 
		while(val.length < 2) { val = '0' + val; }
		color += val;
	}
	return color;
};

const BatteryIndicator = () => Widget.Box({
	height_request: gridSize,
	hpack: "fill",
	child: Widget.Box({ widthRequest: gridSize, class_name: "flashing" })
}).hook(Battery, self => {
	self["css"] = `background-color: ${coloursMix("839B00", "D43E36", Battery.percent)};`;
	if (!Battery.charging && Battery.percent <= 20) self["class_name"] = "flashing"
	else self["class_name"] = ""
}, 'changed');


const Top = () => Widget.Box({
	vertical: true,
	vpack: "start",
	hpack: "fill",
	spacing: gaps,
	children: [
		Clock(),
		Date(),
		Workspaces(),
	],
});

const Center = () => Widget.Box({
	vertical: true,
	hpack: "fill",
	children: [
	],
});

const Bottom = () => Widget.Box({
	vertical: true,
	vpack: 'end',
	hpack: "fill",
	spacing: gaps,
	children: [
		CPUWidget(),
		BatWidget(),
	],
});


export default (monitor = 0) => Widget.Window({
	name: `bar-${monitor}`,
	width_request: 48,
	class_name: "bar",
	monitor,
	layer: "bottom",
	exclusivity: "exclusive",
	margins: [8, 0, 8, 8],
	anchor: ['top', 'left', 'bottom'],
	child: Widget.CenterBox({
		vertical: true,
		start_widget: Top(),
		center_widget: Center(),
		end_widget: Bottom(),
	}),
});

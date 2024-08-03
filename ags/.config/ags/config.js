import Widget from 'resource:///com/github/Aylur/ags/widget.js';
//import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
//import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
//import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
//import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
//import Variable from 'resource:///com/github/Aylur/ags/variable.js'
//import GLib from 'gi://GLib';
//import Gio from 'gi://Gio';
//const { Gtk, Pango } = imports.gi;

import Bar from "./vbar.js";

var dev = true;
if (dev) {
	Utils.monitorFile(
		`${App.configDir}/style.css`,
		(_0, _1) => {
			App.resetCss();
			App.applyCss(`${App.configDir}/style.css`);
			console.log("css reloaded");
		}
	)
}

App.config({ 
	style: App.configDir + "/style.css",
	windows: [Bar()]
});

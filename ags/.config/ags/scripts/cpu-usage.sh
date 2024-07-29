top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} {print ceil(100 - $1)}'

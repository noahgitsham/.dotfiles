top -bn1 | grep "MiB Mem" | sed "s/.* \([0-9.]*\) total, .* \([0-9.]*\) used,.*/\1 \2/" | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} {print ceil($2 / $1 * 100)}'

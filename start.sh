CONFIG_FILE=${ANM3_CONFIG_FILE:-"/etc/anm3rc.awk"}

if [ -r ./anm3rc.awk ]; then
	CONFIG_FILE="./anm3rc.awk"
elif [ -r $HOME/.config/anm3/config.awk ]; then
	CONFIG_FILE="$HOME/.config/amn3/config.awk"
elif [ -r $HOME/.anm3rc.awk ]; then
	CONFIG_FILE="$HOME/.anm3rc.awk"
fi

AWKPATH=$AWKPATH:/usr/share/anm3:. eval "nmfd | gawk -f $CONFIG_FILE"

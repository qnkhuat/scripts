if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi
if [ $# -eq 1 ] 
then
	sed -i '' '/^0.0.0.0/s/^/#/g' "/etc/hosts" 
	echo "unlocked"
else
	sed -i '' '/^#0.0.0.0/s/^#//g' "/etc/hosts" 
	echo "locked"
fi

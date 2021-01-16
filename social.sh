if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi
if [ $# -eq 1 ] 
then
	sed -i '' '/^#0.0.0.0/s/^#//g' "/etc/hosts" # uncomment
	echo "unlocked"
else
	sed -i '' '/^0.0.0.0/s/^/#/g' "/etc/hosts" # comment
	echo "locked"
fi

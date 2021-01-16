if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi
text="0.0.0.0 facebook.com instagram.com youtube.com www.facebook.com www.instagram.com www.youtube.com"
if [ $# -eq 1 ] 
then
	#sed -i '' '/^0.0.0.0/s/^/#/g' "/etc/hosts" 
	sed -i '' -e "/$text/d" /etc/hosts
	echo "unlocked"
else
	#sed -i '' '/^#0.0.0.0/s/^#//g' "/etc/hosts" 
	echo $text >> /etc/hosts
	echo "locked"
fi

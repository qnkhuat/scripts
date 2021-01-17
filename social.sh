# a simple script to block social media sites
if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi
text="0.0.0.0 facebook.com www.facebook.com instagram.com www.instagram.com youtube.com www.youtube.com twitter.com www.twitter.com reddit.com www.reddit.com tinder.com www.tinder.com"
if [ $# -eq 1 ] 
then
	sed -i '' -e "/$text/d" /etc/hosts
	echo "unlocked. Be quick"
else
	echo $text >> /etc/hosts
	echo "locked. I'm proud of you"
fi

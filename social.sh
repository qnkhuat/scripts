# A simple script to block social media sites
# usage:
# type: `social` => lock all sites listed in &site below
# type: `social [whatever]` => unlock sites
# To add a site in the list. Add [site].com and www.[site].com to the $site
# To make this a short cut: add alias social="path to this script" in your bash.rc or zsh.rc

if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi
site="0.0.0.0 facebook.com www.facebook.com instagram.com www.instagram.com youtube.com www.youtube.com twitter.com www.twitter.com reddit.com www.reddit.com tinder.com www.tinder.com"
if [ $# -eq 1 ] # no arguments => lock
then
	sed -i '' -e "/$(echo $site | cut -d' ' -f1 )/d" /etc/hosts
	echo "unlocked. Be quick ಠ_ಠ"
else # if there are arguments => unlcok
	echo $site>> /etc/hosts
	echo "locked. I'm proud of you  (ง'̀-'́)ง"
fi

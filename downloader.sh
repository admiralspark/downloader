#!/bin/bash
echo "Enter the open dir URL: "
read url
echo "Please select:"
showMenu () {
echo "1) Download entire contents."
echo "2) Create an index of content only."
echo "3) Cancel/Quit"
}
while [ 1 ]
do
showMenu
read CHOICE
case "$CHOICE" in
"1")
echo "Now downloading all content from: $url"
echo "Issue 'screen -r OpenDir' to view progress"
screen -dmS OpenDir wget -e robots=off --wait 1 -r --no-parent --reject "index.html*" -nc --continue $url
;;
"2")
echo "Creating index..."
wget -o ./opendir.log -e robots=off -r --no-parent --spider $url
cat ./opendir.log | grep -i Removing > ./sed.log
sed 's/Removing.*www/www/' sed.log > ./sed2.log
sed '/index.html/d' sed2.log > OpenDir.index
rm opendir.log
rm sed.log
rm sed2.log
rm -rf $url
echo "Index 'OpenDir.index' created!"
;;
"3")
exit
;;
esac
done


cwd=$(dirname "$0")
echo $cwd
mkdir -p ~/.hammerspoon/Spoons
cp $cwd/init.lua ~/.hammerspoon/

cd ~/.hammerspoon/Spoons
wget https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip
unzip SpoonInstall.spoon.zip
rm -f SpoonInstall.spoon.zip

cd $cwd

echo "Will set resolution to 1280 x 720"
xrandr -s 1280x720
echo "Will set CPU to performance"
sudo cpupower frequency-set -g performance
cd '/home/overlord/.steam/steam/steamapps/common/Skyrim/'
echo "Starting skyrim"
DRI_PRIME=1 wine Skyrim.exe
echo "xrandr -s 1366x768"

echo 'setting performance mode'
sudo cpupower frequency-set -g performance
cd '/home/overlord/.wine/drive_c/Games/CoDMW3'
DRI_PRIME=1 wine iw5sp.exe  &>/dev/null &

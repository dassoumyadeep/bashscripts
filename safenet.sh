sudo cpupower frequency-set -g performance
echo "Welcome to the Safenet"
clear
echo ""
echo ""
echo ""
echo ""
echo "		OO       OO   OOOOOO   OOOOOO  OOOOOOOO  OO " 
echo "		OO   O   OO  OO    OO    OO       OO     OO " 
echo "		OO  OOO  OO  OO    OO    OO       OO     OO " 
echo "		OO OO OO OO  OOOOOOOO    OO       OO     OO " 
echo "		OOOO   OOOO  OO    OO    OO       OO        " 
echo "		OOO     OOO  OO    OO    OO       OO        " 
echo "		OO       OO  OO    OO  OOOOOO     OO     OO " 
echo ""
echo ""
echo ""
echo ""
ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)

if [ "$ac_adapter" = "on" ]; then     
    notify-send "AC Adapter" "The AC Adapter is on."; 
else     
    notify-send "AC Adapter" "The AC Adapter is off."; 
fi

read -p "Press enter if Laptop is charging : "
clear
if [[ -z "$1" ]] ; then
    echo "No user specified. Going for default user."
    MYUSER='14173006'
else
    MYUSER=$1
fi

echo "Routing for user $MYUSER"
sudo sshuttle --dns -vr $MYUSER@europa -x europa 0.0.0.0/0


# Parameters -> -
# s : Set series, season and episode manually
# r : remove previously saved data
# h : help
# no param : read from /Scripts/Series/.stat.txt and open in VLC

MYSET="-s"
MYREM="-r"
MYLST="-l"
MYHST="-h"
OPENFLAG=1
PARMFIL="/home/overlord/Scripts/series/paramfile.txt"
MDIR="/run/media/overlord/titan/Series/Brooklyn NineNine/Season "

# No inputs parameter specified
if [[ -z "$1" ]] ; then
    # echo "No parameters specified. Going for default episode."
    # echo "Auto isnt supported yet. Please list using l and set using s"
    echo "Please run this script with one of the following params-"
    echo "-s : Specifies the series to be played"
    echo "     Use with the following inputs <name> <season> <episode>"
    echo "     Example ::  viewseries -s 'Brooklyn NineNine' 1 10"
    echo "     Writes to a parameter file for future queries."
	echo "-h : Reads the parameter file and outputs the last watched episode."
	echo "-r : Removes the parameter file. Create new again using -s."
	echo "-l : Lists the available series by browsing Titan and Deimos"
    OPENFLAG=0
else
    PARAM=$1
fi

if [ "$PARAM" = "$MYSET" ]; then
	if [[ -z "$2" ]] ; then
	    echo "Please specify <name> <season> <episode>"
	    echo "Example ::  viewseries -s 'Brooklyn NineNine' 1 10"
	    echo "Will exit now."
	    OPENFLAG=0
	elif [[ -z "$3" ]] ; then
	    echo "Please specify <name> <season> <episode>"
	    echo "Example ::  viewseries -s 'Brooklyn NineNine' 1 10"
	    echo "Will exit now."
	    OPENFLAG=0
	elif [[ -z "$4" ]] ; then
	    echo "Please specify <name> <season> <episode>"
	    echo "Example ::  viewseries -s 'Brooklyn NineNine' 1 10"
	    echo "Will exit now."
	    OPENFLAG=0
	else
	    SER="$2"
	    SEAS="$3"
	    EP="$4"
	    rm $PARMFIL
	    echo "$SER $SEAS $EP" > $PARMFIL
	    echo "$SER $SEAS $EP" 
	    OPENFLAG=1
	fi
    
elif [ "$PARAM" = "$MYREM" ]; then
	rm "$PARMFIL"
    echo "Paramfile removed. Set new using -s."
    OPENFLAG=0
elif [ "$PARAM" = "$MYHST" ]; then
	if [ ! -f "$PARMFIL" ]; then
	    echo "Paramfile not found. Set using -s."
	else
		cat $PARMFIL | while read SER TSEAS TEP
	    do
	        SEAS=($TSEAS + 0)
	        EP=($TEP + 0)
	    done
	    echo "Last Watched : '$SER' $TSEAS $TEP"
	    more $PARMFIL
	fi      
    OPENFLAG=0
elif [ "$PARAM" = "$MYLST" ]; then
    echo "These series are available"
    echo "On Titan"
    ls "/run/media/overlord/titan/Series/"    
    echo "On Deimos"
    ls "/run/media/overlord/Deimos/Series/"
    OPENFLAG=0
else
    echo "Please check you inputs and try again"
    OPENFLAG=0
fi

if [ $OPENFLAG -eq 1 ]; then
	MDIR1="/run/media/overlord/titan/Series/$SER/Season $SEAS"
	MDIR2="/run/media/overlord/Deimos/Series/$SER/Season $SEAS"
	if [ ! -d "$MDIR1" ]; then
	    if [ ! -d "$MDIR2" ]; then
		    echo "Series not found!"	    
		    echo "Browse the list of available series using -l."
		    OPENFLAG=0
		else
			MDIR=$MDIR2
			OPENFLAG=1
		fi 
	else
		MDIR=$MDIR1
		OPENFLAG=1
	fi 
fi

if [ $OPENFLAG -eq 1 ]; then
	echo "'$MDIR'"
	# Add a 0 infront of single digit entries of ep and season
	if [ $SEAS -lt 10 ]; then
	    MSEAS="S0$SEAS"    
	else
	    MSEAS="S$SEAS"    
	fi

	if [ $EP -lt 10 ]; then
	    MEP="E0$EP"    
	else
	    MEP="E$EP"    
	fi

	MVIEW="$SER $MSEAS$MEP"
	MPLAY1="$MDIR/$MVIEW.mkv"
	MPLAY2="$MDIR/$MVIEW.mp4"	
	MPLAY3="$MDIR/$MVIEW.avi"	

	if [ -f "$MPLAY1" ]; then
	    MPLAY=$MPLAY1
		echo "Playing '$MPLAY'"
		echo "Attempting to run file."
	    smplayer "$MPLAY"
	elif [ -f "$MPLAY2" ]; then
	    MPLAY=$MPLAY2
		echo "Playing '$MPLAY'"
		echo "Attempting to run file."
	    smplayer "$MPLAY"
	elif [ -f "$MPLAY3" ]; then
	    MPLAY=$MPLAY3
		echo "Playing '$MPLAY'"
		echo "Attempting to run file."
	    smplayer "$MPLAY"
	else
		echo "avi, mkv or mp4 files not found!"
	    echo "Probably the episode is not available."
	    echo "Browse the list of available series using -l."
	    OPENFLAG=0
	fi    
fi

echo "Script ended."
# Read from ~/Scripts/Series/.stat.txt the current series and episode details


# Increment 1 to the episode and Check if it exists


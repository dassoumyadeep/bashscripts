# Friday 23 April 2021 08:04:24 PM IST
# The ultimate batch tool helper
# By Soumyadeep Das
# Will execute $COMMAND $FNAME$EXT1 $OPTIONS1 $FNAME$EXT2 $OPTIONS2
echo "Welcome to the allpurpose batch scripting tool"
echo "To run <COMMAND WITH OPT> <FNAME><EXT#1> <OPT#1> <FNAME><EXT#2> <OPT#2>"
echo ""
echo "I will read -r all files for a given condition, like *.pdf."
printf "Run desired <ls QUERY>. Enter only the QUERY : "
read -r MQUERY
printf "Enter COMMAND to be run : "
read -r MCMD
# -q is for commands where you need input file name
# -e is for commands where you specify only one file name
# like ps2pdf filename is enough
printf "Enter EXT#1 (with '.'; -q : same as input; -e : empty) : "
read -r EXT1
printf "Enter EXT#2 (with '.'; -q : same as input; -e : empty) : "
read -r EXT2
printf "Enter OPT#1 (leave empty if none) : "
read -r OPT1
printf "Enter OPT#2 (leave empty if none) : "
read -r OPT2

# I will take the first output from ls QUERY
# and show you what the final command would look like.
# Continue or Quit accordingly 
tfile=$(ls $MQUERY | head -n 1)
echo "$tfile"
if [[ $EXT1 = "-q" ]]; then
    TFNAME1="$tfile"
elif [[ $EXT1 = "-e" ]]; then
    TFNAME1=""
else
    TNAME1=`echo "$tfile" | cut -d'.' -f1`
    TFNAME1="$TNAME1$EXT1"
fi
if [[ $EXT2 = "-q" ]]; then
    TFNAME2="$tfile"
elif [[ $EXT2 = "-e" ]]; then
    TFNAME2=""
else
    TNAME2=`echo "$tfile" | cut -d'.' -f1`
    TFNAME2="$TNAME2$EXT2"
fi
echo "Sample command to be run..."
echo "$MCMD $TFNAME1 $OPT1 $TFNAME2 $OPT2"
printf "Actions cannot be undone. Proceed [1] or Exit [0]? : "
read -r DORUN

if [[ DORUN -eq 1 ]]; then
    for file in $MQUERY; do
        if [[ $EXT1 = "-q" ]]; then
            FNAME1="$file"
        elif [[ $EXT1 = "-e" ]]; then
            FNAME1=""
        else
            NAME1=`echo "$file" | cut -d'.' -f1`
            FNAME1="$NAME1$EXT1"
        fi
        if [[ $EXT2 = "-q" ]]; then
            FNAME2="$file"
        elif [[ $EXT2 = "-e" ]]; then
            FNAME2=""
        else
            NAME2=`echo "$file" | cut -d'.' -f1`
            FNAME2="$NAME2$EXT2"
        fi
        # echo "$MCMD $FNAME1 $OPT1 $FNAME2 $OPT2"
        $MCMD $FNAME1 $OPT1 $FNAME2 $OPT2
    done
else
    echo "Exit command given."
fi

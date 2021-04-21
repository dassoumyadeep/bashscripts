# RUNTEX SCRIPT - FOR EASILY COMPILING TEX FILES WITHOUT 
# THE HASSLE OF IDES
# WRITTEN BY SOUMYADEEP DAS
# -------------------------------------------
# No Arguments given
if [[ -z "$1" ]] ; then  
    echo "Welcome to runtex, cli script for running tex files."
    mycase=99
# Single Argument
elif [ "$#" -eq 1 ]; then
    if [[ $1 = "-c" ]]; then
        mycase=5
        filename="NoFilenameGiven"        
    else
        echo "Will run pdf,bib,pdf,pdf on $1.tex"
        filename=$1
        mycase=1
    fi
# Two arguments
elif [ "$#" -eq 2 ]; then
    if [ $1 = "-b" ]; then
        mycase=1
        filename=$2
    elif [ $1 = "-p" ]; then
        mycase=2
        filename=$2
    elif [ $1 = "-x" ]; then
        mycase=3
        filename=$2
    elif [ $1 = "-l" ]; then
        mycase=4
        filename=$2
    elif [ $1 = "-c" ]; then
        mycase=5
        filename=$2
    else
        echo "Please check your inputs and try again."
        mycase=99
    fi
else    
    echo "Please check your inputs and try again."
    mycase=99
fi

if [ $mycase -eq 99 ]; then
    echo "Usage : runtex [param:-bpxlc] [filename]"
    echo "[filename] to be entered without .tex extension."
    echo "List of [param] :"
    echo "-b [filename]: Will run pdf -> bib -> pdf -> pdf [Default]"
    echo "-p [filename]: Will run only pdf on filename.tex"
    echo "-x [filename]: Will run only xe on filename.tex"
    echo "-l [filename]: Will run only lua on filename.tex"
    echo "-c [filename]: Clear the temporary files."
    echo "pdf (pdflatex), bib (bibtex), xe (xelatex), lua (lualatex)."
else
    echo "Welcome to Runtex!"
    filename=${filename%.tex}        
    echo "File is $(pwd)/$filename.tex"
    echo ""
    echo "Cleaning please wait ..."
    rm -f *~
    rm -rf *.aux
    rm -rf *.bbl
    rm -rf *.blg
    rm -rf *.d
    rm -rf *.fls
    rm -rf *.ilg
    rm -rf *.ind
    rm -rf *.toc*
    rm -rf *.lot*
    rm -rf *.lof*
    rm -rf *.log
    rm -rf *.idx
    rm -rf *.out*
    rm -rf *.nlo
    rm -rf *.nls
    rm -rf $filename.pdf
    rm -rf $filename.ps
    rm -rf $filename.dvi
    rm -rf *#* 
    echo "Cleaning complete!"
    echo ""
    echo "Compiling your tex file...please wait...!"
fi

if [ $mycase -eq 1 ] ; then
    pdflatex -interaction=nonstopmode $filename.tex
    bibtex $filename.aux    
    makeindex $filename.aux
    makeindex $filename.idx
    makeindex $filename.nlo -s nomencl.ist -o $filename.nls
    pdflatex -interaction=nonstopmode $filename.tex
    makeindex $filename.nlo -s nomencl.ist -o $filename.nls
    pdflatex -interaction=nonstopmode $filename.tex
    echo " ------ "
    echo ""
    echo "Total citations in this paper : "
    grep -P "You've used [0-9]+ entries," -m 1 "$filename.blg" | grep -P "[0-9]+" -o
elif [ $mycase -eq 2 ] ; then
    pdflatex $filename.tex
elif [ $mycase -eq 3 ] ; then
    xelatex $filename.tex
elif [ $mycase -eq 4 ] ; then
    lualatex $filename.tex
elif [ $mycase -eq 5 ] ; then
    echo "Do you want to clear 'converted-to.pdf's? [Y = 1, N = 0] : "
    read CLRCONV
    if [ $CLRCONV -eq 1 ] ; then
        rm -rf *converted-to.pdf*
        echo "Removed converted-to.pdf files."
    fi
    echo "Temp and Output files cleared."
fi

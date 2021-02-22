echo "Searching ads for Author - $1 and Year - $2"
echo "nargs = $#"

if [ "$#" -eq 3 ]; then
    echo "Searching ads for Author - $1 and $2, and Year - $3"
    firefox "https://ui.adsabs.harvard.edu/search/fq=%7B!type%3Daqp%20v%3D%24fq_database%7D&fq_database=database%3A%20astronomy&q=pubdate%3A%5B$3-01%20TO%20$3-12%5D%20author%3A(%22%5E$1%22%20%22$2%22)&sort=citation_count%20desc%2C%20bibcode%20desc&p_=0" &    
fi

if [ "$#" -eq 2 ]; then
    echo "Searching ads for Author - $1 and Year - $2"
    firefox "https://ui.adsabs.harvard.edu/search/fq=%7B!type%3Daqp%20v%3D%24fq_database%7D&fq_database=database%3A%20astronomy&q=pubdate%3A%5B$2-01%20TO%20$2-12%5D%20author%3A(%22%5E$1%22)&sort=citation_count%20desc%2C%20bibcode%20desc&p_=0" &
fi

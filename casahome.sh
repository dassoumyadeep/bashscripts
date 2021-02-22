# if "${PWD##/home/}" != "${PWD}"

if [ "${PWD}" == "/home/overlord" ]
then
    cd "/home/overlord/.casadir" && casa
    # casa
else
    casa
fi

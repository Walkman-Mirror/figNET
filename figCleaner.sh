#
#
#
#

function cleanFigWebDebris
{

    files=0
    for file in $(ls figWeb/)
    do
        rm $file
    done

}

function cleanUp
{

    cleanFigWebDebris #Cleanup `figWeb/` if figWeb is disabled.

}

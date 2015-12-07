#
#
#
#

function cleanFigWebDebris
{

    for file in $(ls figWeb/)
    do
        rm $file
    done

}

function cleanUp
{

    cleanFigWebDebris #Cleanup `figWeb/` if figWeb is disabled.

}

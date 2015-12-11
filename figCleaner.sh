#figNET Cleaner
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function cleanFigWebDebris #Cleanup `figWeb/` directory
{

    for file in $(ls figWeb/)
    do
        rm $file
    done

}

function cleanUp #Cleanup many aspects of your 
{

    cleanFigWebDebris #Cleanup `figWeb/` directory

}


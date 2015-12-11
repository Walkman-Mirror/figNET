#figNET Software Suite Updater
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Developments

function removeOldFiles
{

    #Remove old files
    rm *.sh quotes.list

}

function updateFiles
{

    #Download all files from GitHub Raw Viewer Storage
    root="https://raw.githubusercontent.com/figNET/figNET/master"
    wget $root/{figAPI.sh,figAutoPeer.sh,figCTL.sh,figCleaner.sh,figInfo.sh,figNode.sh,figQuote.sh,figUpdate.sh,figWeb.sh,figgy.sh,quotes.list} --quiet

}

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
    wget $root/figAPI.sh --progress=dot
    wget $root/figAutoPeer.sh --progress=dot
    wget $root/figCTL.sh 
    wget $root/figCleaner.sh
    wget $root/figInfo.sh --progress=bar
    wget $root/figNode.sh
    wget $root/figQuote.sh
    wget $root/figUpdate.sh
    wget $root/figWeb.sh
    wget $root/figgy.sh
    wget $root/quotes.list

}

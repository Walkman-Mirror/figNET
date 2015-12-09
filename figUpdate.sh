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
    wget https://raw.githubusercontent.com/figNET/figNET/master/figAPI.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figAutoPeer.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figCTL.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figCleaner.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figInfo.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figNode.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figQuote.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figUpdate.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figWeb.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/figgy.sh
    wget https://raw.githubusercontent.com/figNET/figNET/master/quotes.list

}

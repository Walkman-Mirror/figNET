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
    #wget $root/figAPI.sh --quiet
    #wget $root/figAutoPeer.sh --quiet
    #wget $root/figCTL.sh --quiet
    #wget $root/figCleaner.sh --quiet
    #wget $root/figInfo.sh --quiet
    #wget $root/figNode.sh --quiet
    #wget $root/figQuote.sh --quiet
    #wget $root/figUpdate.sh --quiet
    #wget $root/figWeb.sh --quiet
    #wget $root/figgy.sh --quiet
    #wget $root/quotes.list --quiet

}

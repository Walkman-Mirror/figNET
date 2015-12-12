#figNET Information Server

function serveInfoServer
{

    webfsd -i $infoServerIP -p $infoServerPort

}

function checkISEnv
{

    if [ ! -d "infoServ/" ]
    then
        mkdir "infoServ/"
    fi

}

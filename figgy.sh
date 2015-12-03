#Figgy Node Server
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function outText #Output the text in a pretty way
{
	text=$1
	echo "{Figgy} $text"
}

function getConfig
{

	if [ -f node.conf ]
	then
		source node.conf
	else
		outText "Could not find node configuration file."
		exit
	fi

}

function checkConfig
{

	if [ "$internalIP" = "" ] || [ "$internalPort" = "" ] || [ "$publicIP" = "" ] || [ "$publicPort" = "" ] || [ "$nodeName" = "" ] || [ "$nodeLocation" = "" ] || [ "$nodeOperator" = "" ] || [ "$sleepBtwnNodeSync" = "" ] || [ "$sleepBtwnNetworkSync" = "" ] || [ "$usefigCTL" = "" ]
	then
		exit
	fi

}

function importLibs
{

	source figAPI.sh #Get access to all API functions (we might need the code in this script)
	source figNode.sh #Get access to the web server starting function(s)
	source figCTL.sh

}

function killFig
{

	echo "todo"
	echo "no" > status #Stop node syncer

}

function startFig
{

	serveNetwork &
	syncNetwork &

}

function init
{

	importLibs
	outText "Starting node..."

	startFig

	outText "Node has been started."
	outText "Enjoy figNET and be a good-moralled person. :)"
	sleep 5

	if [ $usefigCTL = "true" ]
	then
		console
	else
		clear
	fi

}

getConfig #Import all ariables in `node.conf`
checkConfig #Check if all variables have a value other than `""`
init #Start running the node

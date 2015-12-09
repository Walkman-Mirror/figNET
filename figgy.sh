#figNET Main
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function outText #Output text prefixed with `{Figgy}`
{

	text=$1
	echo "{Figgy}" $text

}

function getConfig #Import all the variables of the configuration file `node.conf`
{

	if [ -f node.conf ]
	then
		source node.conf
	else
		outText "Could not find node configuration file."
		exit
	fi

}

function checkConfig #Check if all the variables in the `node.conf` configuration file have been filled out
{

	if [ "$internalIP" = "" ] || [ "$internalPort" = "" ] || [ "$publicIP" = "" ] || [ "$publicPort" = "" ] || [ "$nodeName" = "" ] || [ "$nodeLocation" = "" ] || [ "$nodeOperator" = "" ] || [ "$nodeOperatorMail" = "" ] || [ "$sleepBtwnNodeSync" = "" ] || [ "$sleepBtwnNetworkSync" = "" ] || [ "$usefigCTL" = "" ] || [ "$enableFigWeb" = "" ] || [ "$figWebHomeRefresh" = "" ] || [ "$figWebServicesInfoPagesRefresh" = "" ] || [ "$figWebServicesRefresh" = "" ] || [ "$figWebNodesRefresh" = "" ] || [ "$figWebIP" = "" ] || [ "$figWebPort" = "" ]
	then
		outText "Configuration file 'node.conf' has variables missing values."
		exit
	fi

}

function importLibs #Import all the code we require
{

	source figAPI.sh #Get access to all API functions (we might need the code in this script)
	source figNode.sh #Get access to the web server starting function(s)
	source figCTL.sh #Get access to the control console for the figNET node
	source figWeb.sh #Get access to the functions in `figWeb.sh`
	source figInfo.sh #Get access to variables containing info about the current release of the figNET suite
	source figAutoPeer.sh #Get access to all the auto-peering-related functions
	source figCleaner.sh #Get access to cleaning code
	source figUpdater.sh #Get access to update code

}

function killFig #Stop this figNET node
{

	echo "no" > status #Stop node syncer

}

function init #Start this figNET node
{

	outText "Importing code into RAM..."
	importLibs
	outText "Code imported into RAM."
	
	outText "Updating your node with the latest software..."
	
	outText "Removing old software..."
	removeOldFiles
	outText "Old software removed."
	
	outText "Fetching and installing new software..."
	updateFiles
	outText "Updates have been installed."
	
	outText "Starting node..."

	outText "Starting node sync..."
	startNode
	outText "Sync started."

	#outText "Starting auto-peering system..."

	#outText "Adding this node to the public nodes list..."
	#addMyself
	#outText "Node has been added to the public node list."

	#outText "Auto-peering taking place..."
	#findPeers
	#outText "Auto-peering completed."

	#outText "Auto-peering system started."

	if [ "$enableFigWeb" = "true" ]
	then
		outText "Starting figWeb..."
		startFigWeb
		outText "figWeb started."
	fi

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

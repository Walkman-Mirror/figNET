#figNET API
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function stopNode #WIP (Do not use)
{

	echo "off" > state

}

function startNode #WIP (Do not use, although we are actually alreadu using it)
{

	serveNetwork &
	syncNetwork &
	echo "on" > state

}

function addService #Add a new service to the network
{

	serviceName=$1
	serviceFriendlyName=$2
	serviceDescription=$3
	generateInfoPage=$4

	if [ $# = 4 ] #Check for correct arity (arity is 4) [serviceName,friendlyName,serviceDescription,true/false for generateInfoPage]
	then
		#Check if the namespace the new service wants is available
		if [ $(isNamespaceTaken "$serviceName") = "false" ] && [ ! "$serviceName" = "" ] && [ ! "$serviceName" = "" ] && [ ! "$serviceName" = "" ] && [ ! "$serviceName" = "" ]
		then
			mkdir "data/$serviceName/" #Create the service
			echo "infoPageGen=\"$generateInfoPage\"
friendlyName=\"$serviceFriendlyName\"
description=\"$serviceDescription\"
			" > "data/$serviceName/.info" #Generate '.info' file for the service
		fi
	fi
}

function isNamespaceTaken #Check if the given service-name is taken on this node
{

	serviceName=$1

	if [ $# = 1 ] #Check for correct arity (arity is 1)
	then
		if [ ! -d "data/$serviceName/" ]
		then
			echo "false"
		else
			echo "true"
		fi
	else
		echo "arity_error"
	fi

}

function isInfoPageEnabled #Check if the gievn service wants an infoPage for figWeb to be generated
{

	if [ $# = 1 ] #Check arity (Arity is 1) [serviceName]
	then
		serviceName=$1
		if [ $(isValidService "$serviceName") = "true" ]
		then
			source "data/$serviceName/.info"
			echo "$infoPageGen"
		fi

	fi

}

function isValidService
{

	serviceName=$1

	valid="false"

	if [ -f "data/$serviceName/.info" ]
	then
		source "data/$serviceName/.info"
		if [ "$infoPageGen" = "true" ] || [ "$infoPageGen" = "false" ] 
		then
			valid="true"
		fi

		if [ ! "$friendlyName" = "" ]
		then
			valid="true"
		fi

		if [ ! "$description" = "" ]
		then
			valid="true"
		fi
	fi

	echo $valid

}

function countServices #Get the number of services running on this node
{

	serviceCount=0
	for service in $(ls data/)
	do
		if [ $(isValidService "$service") = "true" ]
		then
			serviceCount=$(($serviceCount+1))
		fi
	done

	echo $serviceCount
}

function getServices #Returns a list of services on this node
{

	for namespace in $(ls data/)
	do
		if [ $(isValidService "$namespace") = "true" ]
		then
			echo "$namespace"
		fi
	done

}

function startFigWeb
{

	serveFigWeb #Start web server
	generateDedicationsPage & #Generate the dedications page
	generateHomeLoop &
	generateServicesListPage &
	generateNodesListPage &
	generateInfoPageLoop &
#	echo "Kak yeah!"

}

function getSuiteVersion #Get the version for the your current figNET suite
{

	echo "$figNETSuiteVersion"

}

function getSuiteRelease #Get the release name for your current figNET suite
{

	echo "$figNETSuiteRelease"

}

function getNodesCount #Get number of nodes on this node
{

	nodesCount=0

	nodes=$(cat nodes.list)
	for node in $nodes
	do
		nodesCount=$(($nodesCount+1))
	done

	echo $nodesCount
}

function getNodes #Get list of nodes in this node
{

	cat nodes.list

}

function getImportSet #Used for services development (wip - DO not use)
{


	source figAPI.sh #Get access to all API functions (we might need the code in this script)
	source figNode.sh #Get access to the web server starting function(s)
	source figCTL.sh #Get access to the control console for the figNET node
	source figWeb.sh #Get access to the functions in `figWeb.sh`
	source figInfo.sh #Get access to variables containing info about the current release of the figNET suite
	source figAutoPeer.sh #Get access to all the auto-peering-related functions

	source node.info #Get access to configuration variables
	#source figInfo.sh
	#source nodes.list

}

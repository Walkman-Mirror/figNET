#figNET API
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function stopNode #WIP (Do not use)
{

	echo "off" > state

}

function startNode #WIP (Do not use)
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
		#Check if a service with that name already exists
		if [ $(isServiceExist "$serviceName") = "false" ]
		then
			mkdir "data/$serviceName/" #Create the service
			echo "infoPageGen=\"$generateInfoPage\"
friendlyName=\"$serviceFriendlyName\"
description=\"$serviceDescription\"
			" > "data/$serviceName/.info" #Generate '.info' file for the service
		fi
	fi
}

function isServiceExist #Check if the given service exists on this node
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

function isInfoPage #Check if the gievn service wants an infoPage for figWeb to be generated
{

	if [ $# = 1 ] #Check arity (Arity is 1) [serviceName]
	then
		serviceName=$1
		if [ $(isServiceExist "$serviceName") = "true" ]
		then
			source "data/$serviceName/.info"
			echo "$generateInfoPage"
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
		if [ "$infoPageGen" = "true" ] || [ "$genInfoPage" = "false" ] 
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

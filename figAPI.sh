#figAPI
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function shutdownfigNET #WIP
{

	echo "off" > status

}

function addService
{

	serviceName=$1

	if [ $# = 1 ] #Check for correct arity (arity is 1)
	then
		#Check if a service with that name already exists
		if [ $(isServiceExist "$serviceName") = "false" ]
		then
			mkdir "data/$serviceName/" #Create the service
			echo "created_service"
		else
			echo "service_already_exists" #Don't create the service as a service with that name already exists
		fi
	else
		echo "arity_error"
	fi
}

function isServiceExist
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

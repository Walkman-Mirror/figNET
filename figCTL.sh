#figNET Control Console
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function addServiceInteractive
{

	while [ "$serviceName" = "" ]
	do
		echo "Enter the name of the new service:"
		read serviceName
	done

	while [ "$serviceFriendlyName" = "" ]
	do
		echo "Enter the friendly name for service '$serviceName':"
		read serviceFriendlyName
	done

	while [ "$serviceDescription" = "" ]
	do
		echo "Enter a description for your service, '$serviceName':"
		read serviceDescription
	done

	while [ ! "$genInfoPage" = "yes" ] && [ ! "$genInfoPage" = "no" ]
	do
		echo "Would you like an informative page to be created for this service? (yes/no):"
		read genInfoPage
	done

	if [ $(isServiceExist "$serviceName") = "false" ]
	then
		addService "$serviceName" "" "" ""
	else
		echo -e "Error occured while creating service: '$serviceName'!\n"
		echo "A service with the name '$serviceName' already exists."
	fi

}

function console
{
	clear
	echo "Welcome to figCTL!"

	while [ ! "$cmd" = "exit" ]
	do
		echo ">>>"
		read cmd
		if [ "$cmd" = "addservice" ] || [ "$cmd" = "as" ]
		then
			#Start the interactive service creation tool
			addServiceInteractive
		elif [ "$cmd" = "help" ]
		then
			#Show a list of commands
			showHelp
		fi
	done

}

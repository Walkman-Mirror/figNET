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
		if [ "$genInfoPage" = "yes" ]
		then
			genInfoPage="true"
		else
			genInfoPage="false"
		fi
		addService "$serviceName" "$serviceFriendlyName" "$serviceDescription" "$genInfoPage"
	else
		echo -e "Error occured while creating service: '$serviceName'!\n"
		echo "A service with the name '$serviceName' already exists."
	fi

	#Reset all values
	serviceName=""
	serviceFriendlyName=""
	serviceDescription=""
	genInfoPage=""

}

function showHelp
{

	echo "exit		Close figCTL"

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
		elif [ "$cmd" = "stop" ] #WIP (DO NOT USE)
		then
			echo "Stopping figNET node..."
			killFig
			echo "figNET node has been stopped."
		elif [ "$cmd" = "start" ]
		then
			echo "Starting figNET node..."
			startFig
			"figNET node has been started."
		fi
	done

	outText "Bye!"
	sleep 5
	clear

}

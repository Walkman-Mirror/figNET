#figNET Control Console
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function addServiceInteractive #Interactively add a new service to the network
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

	if [ $(isNamespaceTaken "$serviceName") = "false" ]
	then
		if [ ! "$serviceName" = "dedications" ] && [ ! "$serviceName" = "nodes" ] && [ ! "$serviceName" = "index" ] && [ ! "$serviceName" = "services" ]
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
			echo "The namespace '$serviceName' is a reserved namespace and cannot be used!"
		fi
	else
		echo -e "Error occured while creating service: '$serviceName'!\n"
		echo "The namespace '$serviceName' has already been taken."
	fi

	#Reset all values
	serviceName=""
	serviceFriendlyName=""
	serviceDescription=""
	genInfoPage=""

}

function countServicesInteractive #Count all the services interactively
{

	echo "Number of services on this node: $(countServices)"

}

function showVersion
{

	echo "figNET Suite Version: $(getSuiteVersion)"

}

function showRelease
{

	echo "figNET Suite Release: \"$(getSuiteRelease)\""

}

function showHelp #Interactively show help information
{
	echo -e "List of available commands:\n"
	echo "addservice/as	Add a new service."
	echo "countservices/cs	Displays number of services on node."
	echo "stop		Stop this figNET node."
	echo "start 		Start this figNET node."
	echo "help		Show this screen"
	echo "version		Show current version of figNET suite."
	echo "release		Show current release of figNET suite."
	echo "exit		Close figCTL."

}

function console #The console that is used for controlling your figNET node
{
	clear
	echo "Welcome to figCTL v$(getSuiteVersion) \"$(getSuiteRelease)\""

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
			#Work inr progress on the API level
			stopNode
			echo "figNET node has been stopped."
		elif [ "$cmd" = "start" ]
		then
			echo "Starting figNET node..."
			startNode
			"figNET node has been started."
		elif [ "$cmd" = "countservices" ] || [ "$cmd" = "cs" ]
		then
			countServicesInteractive
		elif [ "$cmd" = "version" ]
		then
			showVersion
		elif [ "$cmd" = "release" ]
		then
			showRelease
		fi
	done

	outText "Bye!"
	sleep 5
	clear

}

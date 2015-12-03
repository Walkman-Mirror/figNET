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

	while [ ! "$genInfoPage" = "yes" ] && [ ! "$genInfoPage" = "no" ]
	do
		echo "Would you like an informative page to be created for this service? (yes/no):"
		read genInfoPage
	done

}

function console
{
	clear
	echo "Welcome to figCTL!"

	while [ ! "$cmd" = "exit" ]
	do
		echo ">>>"
		read cmd
		interpret $cmd
	done

}

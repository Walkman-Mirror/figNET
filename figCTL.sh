#figNET Control Console
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

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

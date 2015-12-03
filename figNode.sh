#figNode Network Synchronization
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function serveNetwork
{

	webfsd -i $internalIP -p $internalPort -r data/ #Start webserver

}

function syncWith
{

	nodeAddr=$1
	wget $nodeAddr --mirror --no-host-directories --continue --quiet

}

function syncNetwork
{

	cd data/
	while [ $(cat ../status) = "on" ]
	do

		nodes=$(cat ../nodes.list)
		for node in $nodes
		do

			syncWith $node
			sleep $sleepBtwnNodeSync

		done

		sleep $sleepBtwnNetworkSync

	done

}

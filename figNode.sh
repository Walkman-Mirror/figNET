#figNode Network Synchronization
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function serveNetwork #Start the web-server (webfsd) for serving your `data/` directory to all other nodes
{

	webfsd -i $internalIP -p $internalPort -r data/ #Start webserver

}

function syncWith #Sync with a given node
{

	nodeAddr=$1
	wget $nodeAddr --mirror --no-host-directories --continue --quiet

}

function syncNetwork #Sync with each node in your `nodes.list` file
{

	cd data/
	while [ $(cat ../state) = "on" ]
	do
		echo "Syncing (TEMP)"
		nodes=$(cat ../nodes.list)
		for node in $nodes
		do
			#echo "syncing with node"
			syncWith $node
			sleep $sleepBtwnNodeSync"m"

		done

		sleep $sleepBtwnNetworkSync"m"

	done

}

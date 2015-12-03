#figPeer

function addPeer
{

	echo $node >> nodes.list

}

function addMyself
{

	onTheList="false"

	peers=$(cat data/.peers)
	for peer in $peers
	do
		if [ $pubicIP:$publicPort = $peer ]
		then
			onTheList="true"
		fi
	done

	if [ $onTheList = "false" ]
	then
		echo $publicIP:$publicPort >> data/.peers
	fi
}

function findPeers
{
	myNodes=$(cat nodes.list)
	remoteNodes=$(cat data/.peers)
	for node in $myNodes
	do
		for remoteNode in $remoteNodes
		do
			if [ ! $node = $remoteNode ]
			then
				addPeer $remoteNode
			fi
		done
	done

}

#figPeer

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

function servefigWeb #Start the figWeb web-server
{

	webfsd -i $figWebIP -p $figWebPort -r infoPage/index.html

}

function generateInfoPage
{

	serviceName=$1
	serviceFriendlyName=$2
	serviceDescription=$3

	page="


"

	echo "$page" #Return the infoPage's HTML code

}

function generateInfoPageLoop
{

	for service in $(getServices)
	do

		source "data/$service/.info"
		if [ $(isInfoPageEnabled "$service") = "true" ] #Generate an infoPage for this service
		then
			generateInfoPage "$service" "$serviceFriendlyName" "$serviceDescription" > "figWebs/$service.html"
		fi

	done
	#echo "todo"

}

function generateHomeLoop
{

	while [ 1 = 1 ]
	do

		page="<html>
		<head>
			<title>figWeb for figNET on $nodeName</title>
		</head>

		<body><center><font face=\"Liberation Sans\">

			<h1>$nodeName</h1>
			<h3>Running on figNET <i>v$figNET_VERSION</i></h3>
			<hr>

			<h2><u>Node information</u></h2>
			<p><b>Node's name: </b>$nodeName</p>
			<p><b>Node's hostname: </b>$HOSTNAME</p>
			<p><><></p>
			<p><><></p>
			<p><><></p>
			<p><><></p>

		</font></center></body>

</html>"

		echo "$page" > infoPage/index.html

		sleep 60 #Wait 60 seconds before re-generating a fresh figWeb `index.html` file (in infoPage/index.html)

	done

}

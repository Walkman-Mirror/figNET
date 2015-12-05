#figNET Web frontend
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function servefigWeb #Start the figWeb web-server
{

	webfsd -i $figWebIP -p $figWebPort -r infoPage/index.html

}

function generateInfoPage #Generate infoPage for a specified service
{

	serviceName=$1
	serviceFriendlyName=$2
	serviceDescription=$3

	page="<html>
	<head>
		<title>Information for $serviceName | figNET</title>
	</head>

	<body><center><font face=\"Liberation Sans\">

		<h1>$nodeName</h1>
                <h3>Running on figNET <i>v$figNET_VERSION</i></h3>
                <hr>

		<h2><u>Information for service: $serviceName</u></h2>
		<p>Service name: <b>$serviceName</b></p>
		<p>Service friendly name: <b>$serviceFriendlyName</b></p>
		<p><b>Description of service:</b></p>
		<code>
		$serviceDescription
		</code>


	</font></center></body>



</html>
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
			generateInfoPage "$service" "$serviceFriendlyName" "$serviceDescription" > "figWeb/$service.html"
		fi

	done

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
			<p><b>Node's OS: </b>$(uname --operating-system)</p>
			<p><b>Node's location: </b>$nodeLocation</p>
			<p><b>SysOp: </b>$nodeOperator</p>
			<p><b>SysOp's email address: </b><a href=\"mailto:$nodeOperatorMail\">$nodeOperatorMail</a></p>

		</font></center></body>

		<br>
		<hr>
		<br>

		<footer><center><font face=\"Liberation Sans\">

			<code>Built avec <3.</code>
			<p>fig<b>NET</b> is <a href=\"https://gnu.org/free-sw.html\">Free Sofware</a> and is licensed under the GNU GPL v3.</p>
			<p>This is a project created and maintained by <a href=\"https://deavmi.github.io\">Tristan B. Kildaire (Deavmi)</a>. It is part of Crowbar Developments.</p>

		</font></center></footer>

</html>"

		echo "$page" > infoPage/index.html

		sleep 60 #Wait 60 seconds before re-generating a fresh figWeb `index.html` file (in infoPage/index.html)

	done

}

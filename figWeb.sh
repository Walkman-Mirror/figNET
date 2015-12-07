#figNET Web frontend
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function serveFigWeb #Start the figWeb web-server
{

	webfsd -i $figWebIP -p $figWebPort -f figWeb/index.html

}

function generateDedicationsPage #wip
{
	
	page="<html>
	<head>
		<title>Dedications</title>
	</head>
	
	<body bgcolor=\"53c69b\"><center><font face=\"Liberation Sans\">
	
		<h1>Dedications></h1>
		<p>A few words to who I dedicate this software to...</p>
		
		
	
	</font></center></body>

</html>"
	
}

function generateServicesListPage #Generate the list of services page
{

	while [ 1 = 1 ]
	do

	page="<html>
	<head>
		<title>Services | figNET</title>
	</head>

	<body><center><font face=\"Liberation Sans\">

		<h1>$nodeName</h1>
                <h3>Running on figNET v$(getSuiteVersion) <i>\"$(getSuiteRelease)</i>\"</h3>
                <hr>

		<h2><u>Services</u></h2>
		<p>There are $(countServices) services running on this node.</p>
		<ol>
			$(generateServicesList)
		</ol>


	</font></center></body>

	<br>
	<hr>
	<br>

	<footer><center><font face=\"Liberation Sans\">

		<code>Page last generated: $(date)</code>
		<br>
		<br>
                <a href=\"figWeb/dedications.html\"><code>Built avec <3.</code></a>
		<p>fig<b>NET</b> is <a href=\"https://gnu.org/free-sw.html\">Free Sofware</a> and is licensed under the GNU GPL v3.</p>
		<p>This is a project created and maintained by <a href=\"https://deavmi.github.io\">Tristan B. Kildaire (Deavmi)</a>. It is part of Crowbar Developments.</p>

        </font></center></footer>

</html>
"

	echo "$page" > figWeb/services.html

		sleep $figWebServicesRefresh

	done

}

function generateNodesListPage #Generate the list of nodes page
{

	while [ 1 = 1 ]
	do

		page="<html>
	<head>
		<title>Nodes | figNET</title>
	</head>

	<body><center><font face=\"Liberation Sans\">

		<h1>$nodeName</h1>
                <h3>Running on figNET v$(getSuiteVersion) <i>\"$(getSuiteRelease)</i>\"</h3>
                <hr>

		<h2><u>Nodes</u></h2>
		<p>This node is connected to $(getNodesCount) nodes.</p>
		<ol>
			$(generateNodesList)
		</ol>


	</font></center></body>

	<br>
	<hr>
	<br>

	<footer><center><font face=\"Liberation Sans\">

		<code>Page last generated: $(date)</code>
		<br>
		<br>
                <a href=\"figWeb/dedications.html\"><code>Built avec <3.</code></a>
		<p>fig<b>NET</b> is <a href=\"https://gnu.org/free-sw.html\">Free Sofware</a> and is licensed under the GNU GPL v3.</p>
		<p>This is a project created and maintained by <a href=\"https://deavmi.github.io\">Tristan B. Kildaire (Deavmi)</a>. It is part of Crowbar Developments.</p>

        </font></center></footer>

</html>
"

	echo "$page" > figWeb/nodes.html

		sleep $figWebNodesRefresh

	done

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
                <h3>Running on figNET v$(getSuiteVersion) <i>\"$(getSuiteRelease)</i>\"</h3>
                <hr>

		<h2><u>Information for service: $serviceName</u></h2>
		<p><b>Service name: </b>$serviceName</p>
		<p><b>Service friendly name: </b>$serviceFriendlyName</p>
		<p><b>Description of service:</b></p>
		<code>
		$serviceDescription
		</code>


	</font></center></body>

	<br>
	<hr>
	<br>

	<footer><center><font face=\"Liberation Sans\">

		<code>Page last generated: $(date)</code>
		<br>
		<br>
                <a href=\"figWeb/dedications.html\"><code>Built avec <3.</code></a>
		<p>fig<b>NET</b> is <a href=\"https://gnu.org/free-sw.html\">Free Sofware</a> and is licensed under the GNU GPL v3.</p>
		<p>This is a project created and maintained by <a href=\"https://deavmi.github.io\">Tristan B. Kildaire (Deavmi)</a>. It is part of Crowbar Developments.</p>

        </font></center></footer>

</html>
"

	echo "$page" #Return the infoPage's HTML code

}

function generateInfoPageLoop #Generate pages for all services that want it
{

	while [ 1 = 1 ]
	do
		for service in $(getServices)
		do

			source "data/$service/.info"
			if [ $(isInfoPageEnabled "$service") = "true" ] #Generate an infoPage for this service
			then
				generateInfoPage "$service" "$friendlyName" "$description" > "figWeb/$service.html"
			fi
		done

		sleep $figWebServicesInfoPagesRefresh

	done

}

function generateServicesList #Generate a service list item
{

	for service in $(getServices)
	do
		echo "<li><a href=\"figWeb/$service.html\">$service</a></li>"
	done

}

function generateNodesList #Generate a node list item
{

	for node in $(getNodes)
	do
		echo "<li>$node</li>"
	done

}

function generateHomeLoop #Generate index.html file
{

	while [ 1 = 1 ]
	do

		page="<html>
		<head>
			<title>figWeb for figNET on $nodeName</title>
		</head>

		<body><center><font face=\"Liberation Sans\">

			<h1>$nodeName</h1>
			<h3>Running on figNET v$(getSuiteVersion) <i>\"$(getSuiteRelease)\"</i></h3>
			<hr>

			<a href=\"figWeb/services.html\"><h2><u>Services</u></h2></a>
			<p>There are $(countServices) services running on this node.</p>
			<ol>
				$(generateServicesList)
			</ol>

			<a href=\"figWeb/nodes.html\"><h2><u>Nodes</u></h2></a>
			<p>This node is connected to $(getNodesCount) nodes.</p>
			<ol>
				$(generateNodesList)
			</ol>

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

			<code>Page last generated: $(date)</code>
			<br>
			<br>
        	        <a href=\"figWeb/dedications.html\"><code>Built avec <3.</code></a>
			<p>fig<b>NET</b> is <a href=\"https://gnu.org/free-sw.html\">Free Sofware</a> and is licensed under the GNU GPL v3.</p>
			<p>This is a project created and maintained by <a href=\"https://deavmi.github.io\">Tristan B. Kildaire (Deavmi)</a>. It is part of Crowbar Developments.</p>

		</font></center></footer>

</html>"

		echo "$page" > figWeb/index.html

		sleep $figWebHomeRefresh #Wait 60 seconds before re-generating a fresh figWeb `index.html` file (in infoPage/index.html)

	done

}

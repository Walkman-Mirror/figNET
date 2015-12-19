#figNET Web frontend
#Written by: Tristan B. Kildaire (Deavmi) - (deavmi@disroot.org)
#License: GNU GPL v3
#Crowbar Development

function serveFigWeb #Start the figWeb web-server
{

	webfsd -i $figWebIP -p $figWebPort -f figWeb/index.html

}

function generateDedicationsPage #Generate the dedications page
{
	
	page="<html>
	<head>
		<title>Dedications</title>
	</head>
	
	<body bgcolor=\"53c69b\"><center><font face=\"Liberation Sans\">
	
		<h1>✞</h1>
		<h1>Dedications</h1>
		<p>A few words to who I dedicate this software to...</p>
		
		<blockquote>
		
			$dedicationMessage
		
		</bockquote>
	
	</font></center></body>

</html>"

	echo "$page" > figWeb/dedications.html
	
}

function generateServicesListPage #Generate the list of services page
{

	while [ 1 = 1 ]
	do

	page="<html>
	<head>
		<title>Services | figWeb</title>
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
                <a href=\"http://$figWebPublicIP:$figWebPublicPort/figWeb/dedications.html\"><code>Built avec <3.</code></a>
		<p>fig<b>NET</b> is <a href=\"https://gnu.org/philosophy/free-sw.html\">Free Software</a> and is licensed under the GNU GPL v3. <a href=\"https://github.com/figNET/figNET\">Source Code available</a></p>
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
		<title>Nodes | figWeb</title>
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
                <a href=\"http://$figWebPublicIP:$figWebPublicPort/figWeb/dedications.html\"><code>Built avec <3.</code></a>
		<p>fig<b>NET</b> is <a href=\"https://gnu.org/philosophy/free-sw.html\">Free Software</a> and is licensed under the GNU GPL v3. <a href=\"https://github.com/figNET/figNET\">Source Code available</a></p>
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
		<title>Information for $serviceName | figWeb</title>
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
                <a href=\"http://$figWebPublicIP:$figWebPublicPort/figWeb/dedications.html\"><code>Built avec <3.</code></a>
		<p>fig<b>NET</b> is <a href=\"https://gnu.org/philosophy/free-sw.html\">Free Software</a> and is licensed under the GNU GPL v3. <a href=\"https://github.com/figNET/figNET\">Source Code available</a></p>
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
		echo "<li><a href=\"http://$figWebPublicIP:$figWebPublicPort/figWeb/$service.html\">$service</a></li>"
	done

}

function generateNodesList #Generate a node list item
{

	for node in $(getNodes)
	do
		echo "<li><a href=\"http://$node\">$node</a></li>"
	done

}



###BEEEEETAAAAAAAAAAAA


function generateServicesList5 #Generate a service list item (fist 5)
{

	count=0

	for service in $(getServices)
	do
			echo "<li><a href=\"http://$figWebPublicIP:$figWebPublicPort/figWeb/$service.html\">$service</a></li>"
			count=$(($count+1))

			if [ $count = 5 ]
			then
					break
			fi
	done

}

function generateNodesList5 #Generate a node list item (first 5)
{

	count=0

	for node in $(getNodes)
	do
		echo "<li><a href=\"http://$node\">$node</a></li>"
		
		count=$(($count+1))

		if [ $count = 5 ]
		then
				break
		fi
	done

}

















###END BETTTTATATTATATATATA




function generateHomeLoop #Generate index.html file
{

	while [ 1 = 1 ]
	do

		page="<html>
		<head>
			<meta charset="utf-8">
			<title>$nodeName | figWeb</title>
		</head>

		<body><center><font face=\"Liberation Sans\">

			<h1>$nodeName</h1>
			<h3>Running on figNET v$(getSuiteVersion) <i>\"$(getSuiteRelease)\"</i></h3>
			<hr>

			<a href=\"figWeb/services.html\"><h2><u>Services</u></h2></a>
			<p>There are $(countServices) services running on this node.</p>
			<ol>
				$(generateServicesList5)
			</ol>

			<a href=\"figWeb/nodes.html\"><h2><u>Nodes</u></h2></a>
			<p>This node is connected to $(getNodesCount) nodes.</p>
			<ol>
				$(generateNodesList5)
			</ol>

			<h2><u>Node information</u></h2>
			<p><b>Node name: </b>$nodeName</p>
			<p><b>Node Sync Server: </b><a href=\"http://$publicIP:$publicPort\">$publicIP:$publicPort</a></p>
			<p><b>Node hostname: </b>$HOSTNAME</p>
			<p><b>Node OS: </b>$(uname --operating-system)</p>
			<p><b>Node location: </b>$nodeLocation</p>
			<p><b>SysOp: </b>$nodeOperator</p>
			<p><b>SysOp email address: </b><a href=\"mailto:$nodeOperatorMail\">$nodeOperatorMail</a></p>

		</font></center></body>

		<br>
		<hr>
		<br>

		<footer><center><font face=\"Liberation Sans\">

			<code>Page last generated: $(date)</code>
			<br>
			<br>
        	        <a href=\"figWeb/dedications.html\"><code>Built avec <3.</code></a>
			<p>fig<b>NET</b> is <a href=\"https://gnu.org/philosophy/free-sw.html\">Free Software</a> and is licensed under the GNU GPL v3. <a href=\"https://github.com/figNET/figNET\">Source Code available</a></p>
			<p>This is a project created and maintained by <a href=\"https://deavmi.github.io\">Tristan B. Kildaire (Deavmi)</a>. It is part of Crowbar Developments.</p>

		</font></center></footer>

</html>"

		echo "$page" > figWeb/index.html

		sleep $figWebHomeRefresh #Wait gievn amount of seconds before re-generating a fresh figWeb `index.html` file (in infoPage/index.html)

	done

}

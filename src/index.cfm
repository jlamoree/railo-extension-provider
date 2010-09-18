<cfsilent>
	<cfset provider = createObject("component", "ExtensionProvider")/>
	<cfset extensions = provider.listApplications()/>
</cfsilent>
<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>Lamoree Software - Railo Extension Provider</title>
	<link rel="stylesheet" href="assets/stylesheets/master.css"/>
	<link rel="shortcut icon" href="assets/images/favicon.ico" type="image/x-icon"/>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"/></script>

	<script>
		$(document).ready(function() {
			$("a.action").each(function() {
				$this = $(this);
				$this.attr("title", $this[0].text);
			});
		});
	</script>
</head>
<body>
<div id="page">
	<div id="header">
		<h1>Lamoree Software</h1>
	</div>
	<div id="content">
		<h3>Railo Extension Provider</h3>

		<p>
		This server is simple Railo <a href="http://www.getrailo.com/index.cfm/products/railo-extensions/">extension provider</a>. For more information, see Railo's page on <a href="http://www.getrailo.org/index.cfm/documentation/writing-extensions/">writing extensions</a>.
		</p>

		<h3>Installation</h3>
		<p>
		To add this extension provider to your Railo installation, open the Web Administrator and add the following URL to the providers list:
		</p>
		<pre>@providerURL@ExtensionProvider.cfc</pre>

		<h3>Available Extensions</h3>
		<p>
		The following extensions are available:
		</p>
		<table class="extensions" cellspacing="0">
		<thead>
			<tr>
				<td>&nbsp;</td>
				<td>Category</td>
				<td>Name</td>
				<td>Author</td>
				<td>Version</td>
				<td>Build Date</td>
				<td>Package</td>
			</tr>
		</thead>
		<cfoutput query="extensions">
			<tbody>
				<tr>
					<td>
						<a id="info" class="action" href="info.cfm?id=#extensions.id#">Package Information</a>
						<a id="site" class="action" href="#extensions.documentation#">Project Homepage</a>
					</td>
					<td>#extensions.category#</td>
					<td>#extensions.label#</a></td>
					<td>#extensions.author#</td>
					<td>#extensions.version#</td>
					<td>#dateFormat(extensions.created, "yyyy-mm-dd")# #timeFormat(extensions.created, "HH:mm:ss")#</td>
					<td><a href="#extensions.download#">#extensions.package#</a> (#extensions.size#)</td>
				</tr>
			</tbody>
		</cfoutput>
		</table>

		<h3>Source Code</h3>
		<p>
		The source code for this project is at Github: <a href="http://github.com/jlamoree/railo-extension-provider">jlamoree/railo-extension-provider</a>
		</p>
	</div>
	<div id="footer">
		<cfif server.coldfusion.productname eq "Railo">
			#server.coldfusion.productname# #server.railo.version#
		</cfif>
	</div>
</body>
</html>
</cfoutput>
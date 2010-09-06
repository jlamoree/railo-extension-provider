<cfsilent>
	<cfset title = "Railo Extension Provider"/>
	<cfset provider = createObject("component", "ExtensionProvider")/>
	<cfset extensions = provider.listApplications()/>
</cfsilent>
<cfoutput>
<html>
<head>
	<title>Lamoree Software - #title#</title>
	<link rel="stylesheet" href="assets/stylesheets/master.css"/>
</head>
<body>
<h1>#title#</h1>

<p>
This server is simple Railo <a href="http://www.getrailo.com/index.cfm/products/railo-extensions/">extension provider</a>. For more information, see Railo's page on <a href="http://www.getrailo.org/index.cfm/documentation/writing-extensions/">writing extensions</a>.
</p>
<h2>Installation</h2>
<p>
To add this extension provider to your Railo installation, open the Web Administrator and add the following URL to the providers list:
</p>
<pre>@providerURL@ExtensionProvider.cfc</pre>

<h2>Extensions</h2>
<p>
The following extensions are available:
</p>
<table border="1">
<tr>
	<th>Category</th>
	<th>Name</th>
	<th>Author</th>
	<th>Version</th>
	<th>Built</th>
</tr>
<cfoutput query="extensions">
	<tr id="#extensions.id#">
		<td>#extensions.category#</td>
		<td><a href="#extensions.documentation#">#extensions.label#</a></td>
		<td>#extensions.author#</td>
		<td>#extensions.version#</td>
		<td>#dateFormat(extensions.created, "yyyy-mm-dd")# #timeFormat(extensions.created, "HH:mm:ss")#</td>
	</tr>
</cfoutput>
</table>

<h3>Source Code</h3>
<p>
The source code for this project is at Github: <a href="http://github.com/jlamoree/railo-extension-provider">jlamoree/railo-extension-provider</a>
</p>

</body>
</html>
</cfoutput>
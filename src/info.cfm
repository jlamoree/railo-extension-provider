<cfsilent>
	<cfparam name="url.id" default=""/>

	<cfset provider = createObject("component", "ExtensionProvider")/>
	<cfset extensions = provider.listApplications()/>

	<cfset result = {abort=false, success=false, message=""}/>

	<cfif url.id eq "">
		<cfset result.abort = true/>
		<cfset result.message = "The extension package identifier must be included in the URL."/>
	</cfif>

	<cfif not result.abort>
		<cfquery name="package" dbtype="query">
			SELECT *
			FROM extensions
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.id#"/>
		</cfquery>
		<cfif package.recordCount eq 1>
			<cfset result.success = true/>
		<cfelse>
			<cfset result.abort = true/>
		</cfif>
	</cfif>

	<cfscript>
		properties = [
			{name="id", label="ID:"},
			{name="category", label="Category:"},
			{name="version", label="Version:"},
			{name="created", label="Build Date:"},
			{name="author", label="Author:"},
			{name="homepage", label="Homepage:"},
			{name="support", label="Support:"},
			{name="documentation", label="Documentation:"},
			{name="forum", label="Forum:"},
			{name="mailinglist", label="Mailing List:"},
			{name="sha1", label="Hash (SHA1):"},
			{name="md5", label="Hash (MD5):"}
		];
	</cfscript>


</cfsilent>
<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>Lamoree Software - Railo Extension Provider</title>
	<link rel="stylesheet" href="assets/stylesheets/master.css"/>
	<link rel="shortcut icon" href="assets/images/favicon.ico" type="image/x-icon"/>
</head>
<body>
<div id="page">
	<div id="header">
		<h1>Lamoree Software</h1>
	</div>
	<div id="content">
		<h3>Railo Extension Package Information</h3>

		<cfoutput>
			<cfif result.success>
				<div id="package-info">
					<h4>#package.label#</h4>
					<table cellspacing="0">
					<tbody>
						<cfloop array="#properties#" index="property">
							<cfif len(package[property.name]) gt 0>
								<tr>
									<td class="label">#property.label#</td>
									<td>
										<cfif reFindNoCase("^http", package[property.name]) eq 1>
											<a href="#package[property.name]#">#package[property.name]#</a>
										<cfelseif isDate(package[property.name])>
											#dateFormat(package[property.name], "dd mmm yyyy")# #timeFormat(package[property.name], "HH:mm")#
										<cfelse>
											#package[property.name]#
										</cfif>
									</td>
								</tr>
							</cfif>
						</cfloop>
						<tr>
							<td class="label">Package:</td>
							<td>
								<a href="#package.download#">#package.package#</a> (#package.size#)
							</td>
						</tr>
					</tbody>
					</table>

					<p>#package.description#</p>
					<cfif len(package.homepage) gt 0>
						<a href="#package.homepage#"><img src="#package.image#"/></a>
					<cfelse>
						<img src="#package.image#"/>
					</cfif>
				</div>
			<cfelse>
				<p>#result.message#</p>
			</cfif>
		</cfoutput>
		<p class="clear"><a href="./">All Available Extensions</a></p>
	</div>
	<div id="footer">
		<cfif server.coldfusion.productname eq "Railo">
			#server.coldfusion.productname# #server.railo.version#
		</cfif>
	</div>
</body>
</html>
</cfoutput>
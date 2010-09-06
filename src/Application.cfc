<cfcomponent>

	<cfset this.name = "RailoExtensionProviderApp"/>
	<cfset this.appRoot = getDirectoryFromPath(getMetadata(this).path)/>
	<cfset this.mappings = structNew()/>
	<cfset this.mappings["/extensions"] = this.appRoot & "extensions"/>

</cfcomponent>
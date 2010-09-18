<cfcomponent extends="extensions.BaseExtension" output="false">

	<cffunction name="getInfo" returntype="struct" access="public" output="false">
		<cfargument name="provider" type="struct" required="true"/>

		<cfset var info = super.getInfo()/>

		<cfset info.id = "@extensionId@"/>
		<cfset info.name = "@extensionName@"/>
		<cfset info.type = "web"/>
		<cfset info.label = "Mach-II Dashboard 1.1.0"/>
		<cfset info.description = "This version of the Mach-II Dashboard should be used with Mach-II Framework 1.8+. Future versions of the framework will have the dashboard built-in."/>
		<cfset info.author = "Mach-II Developers"/>
		<cfset info.image = "#arguments.provider.url#assets/images/machii-logo.jpg"/>
		<cfset info.homepage = "http://www.mach-ii.com/"/>
		<cfset info.support = "http://groups.google.com/group/mach-ii-for-coldfusion"/>
		<cfset info.mailinglist = "http://groups.google.com/group/mach-ii-for-coldfusion"/>
		<cfset info.documentation = "http://trac.mach-ii.com/machii/wiki/Dashboard"/>
		<cfset info.created = parseDateTime("@extensionTimestamp@")/>
		<cfset info.version = "@extensionVersion@"/>
		<cfset info.category = "Framework Add-On"/>
		<cfset info.package = "#info.name#-#info.version#-railo-extension.zip"/>
		<cfset info.download = "#arguments.provider.url#extensions/#info.package#"/>
		<cfset info.size = getFileSize(expandPath("/extensions/#info.package#"))/>
		<cfreturn info/>
	</cffunction>
</cfcomponent>
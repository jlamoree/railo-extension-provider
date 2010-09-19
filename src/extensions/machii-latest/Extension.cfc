<cfcomponent extends="extensions.BaseExtension" output="false">

	<cffunction name="getInfo" returntype="struct" access="public" output="false">
		<cfargument name="provider" type="struct" required="true"/>

		<cfset var info = super.getInfo()/>

		<cfset info.id = "@extensionId@"/>
		<cfset info.name = "@extensionName@"/>
		<cfset info.label = "@extensionLabel@"/>
		<cfset info.type = "web"/>
		<cfset info.description = "This is the bleeding edge snapshot taken from the project Subversion repository."/>
		<cfset info.author = "Mach-II Developers"/>
		<cfset info.image = "#arguments.provider.url#assets/images/machii-logo.jpg"/>
		<cfset info.homepage = "http://www.mach-ii.com/"/>
		<cfset info.support = "http://groups.google.com/group/mach-ii-for-coldfusion"/>
		<cfset info.mailinglist = "http://groups.google.com/group/mach-ii-for-coldfusion"/>
		<cfset info.documentation = "http://trac.mach-ii.com/machii/wiki"/>
		<cfset info.created = parseDateTime("@extensionTimestamp@")/>
		<cfset info.version = "@extensionVersion@"/>
		<cfset info.category = "Framework"/>
		<cfset info.package = "#info.name#-#info.version#-railo-extension.zip"/>
		<cfset info.download = "#arguments.provider.url#extensions/#info.package#"/>
		<cfset info.size = getFileSize(expandPath("/extensions/#info.package#"))/>
		<cfset info.md5 = "@extensionMD5@"/>
		<cfset info.sha1 = "@extensionSHA1@"/>
		<cfreturn info/>
	</cffunction>
</cfcomponent>
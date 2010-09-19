<cfcomponent extends="extensions.BaseExtension" output="false">

	<cffunction name="getInfo" returntype="struct" access="public" output="false">
		<cfargument name="provider" type="struct" required="true"/>

		<cfset var info = super.getInfo()/>

		<cfset info.id = "@extensionId@"/>
		<cfset info.name = "@extensionName@"/>
		<cfset info.label = "@extensionLabel@"/>
		<cfset info.type = "web"/>
		<cfset info.description = "This package contains revisions in the legacy repository made after the ColdSpring 1.2 release."/>
		<cfset info.author = "ColdSpring Developers"/>
		<cfset info.image = "#arguments.provider.url#assets/images/coldspring.png"/>
		<cfset info.homepage = "http://www.coldspringframework.org/"/>
		<cfset info.documentation = "http://www.coldspringframework.org/index.cfm/go/documentation"/>
		<cfset info.mailinglist = "http://groups.google.com/group/coldspring-users"/>
		<cfset info.created = parseDateTime("@extensionTimestamp@")/>
		<cfset info.version = "@extensionVersion@"/>
		<cfset info.category = "DI/AOP Framework"/>
		<cfset info.package = "#info.name#-#info.version#-railo-extension.zip"/>
		<cfset info.download = "#arguments.provider.url#extensions/#info.package#"/>
		<cfset info.size = getFileSize(expandPath("/extensions/#info.package#"))/>
		<cfset info.md5 = "@extensionMD5@"/>
		<cfset info.sha1 = "@extensionSHA1@"/>
		<cfreturn info/>
	</cffunction>
</cfcomponent>
<cfcomponent extends="extensions.BaseExtension" output="false">

	<cffunction name="getInfo" returntype="struct" access="public" output="false">
		<cfargument name="provider" type="struct" required="true"/>

		<cfset var info = super.getInfo()/>

		<cfset info.id = "@extensionId@"/>
		<cfset info.name = "@extensionName@"/>
		<cfset info.type = "web"/>
		<cfset info.label = "CFPayment"/>
		<cfset info.description = "A ColdFusion library for interfacing with several popular payment gateways using a standard API."/>
		<cfset info.author = "Brian Ghidinelli"/>
		<cfset info.image = "#arguments.provider.url#assets/images/cfpayment-logo.png"/>
		<cfset info.mailinglist = "http://groups.google.com/group/cfpayment"/>
		<cfset info.created = parseDateTime("@extensionTimestamp@")/>
		<cfset info.version = "@extensionVersion@"/>
		<cfset info.category = "Library"/>
		<cfset info.package = "#info.name#-#info.version#-railo-extension.zip"/>
		<cfset info.download = "#arguments.provider.url#extensions/#info.package#"/>
		<cfset info.size = getFileSize(expandPath("/extensions/#info.package#"))/>
		<cfreturn info/>
	</cffunction>
</cfcomponent>
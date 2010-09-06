<cfcomponent extends="extensions.BaseExtension" output="false">

	<cffunction name="getInfo" returntype="struct" access="public" output="false">
		<cfargument name="provider" type="struct" required="true"/>

		<cfset var info = super.getInfo()/>

		<cfset info.id = "@extensionId@"/>
		<cfset info.name = "@extensionName@"/>
		<cfset info.type = "web"/>
		<cfset info.label = "Transfer ORM Latest"/>
		<cfset info.description = "Transfer ORM's main focus is to automate the repetitive tasks of creating the SQL and custom CFCs that are often required when developing a ColdFusion application. Through a central configuration file Transfer knows how to generate objects, and how to manage them and their relationships back to the database."/>
		<cfset info.author = "Mark Mandel"/>
		<cfset info.image = "#arguments.provider.url#assets/images/transfer.jpg"/>
		<cfset info.documentation = "http://docs.transfer-orm.com/"/>
		<cfset info.mailinglist = "http://groups.google.com/group/transfer-dev"/>
		<cfset info.created = parseDateTime("@extensionTimestamp@")/>
		<cfset info.version = "@extensionVersion@"/>
		<cfset info.category = "ORM Library"/>
		<cfset info.package = "#info.name#-#info.version#-railo-extension.zip"/>
		<cfset info.download = "#arguments.provider.url#extensions/#info.package#"/>
		<cfset info.size = getFileSize(expandPath("/extensions/#info.package#"))/>
		<cfreturn info/>
	</cffunction>
</cfcomponent>
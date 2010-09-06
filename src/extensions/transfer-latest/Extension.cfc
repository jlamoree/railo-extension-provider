<cfcomponent output="false">

	<cffunction name="getInfo" returntype="struct" access="public" output="false">
		<cfargument name="provider" type="struct" required="true"/>

		<cfset var info = structNew()/>

		<cfset info.id = "@extensionId@"/>
		<cfset info.name = "@extensionName@"/>
		<cfset info.type = "web"/>
		<cfset info.label = "Transfer ORM Latest"/>
		<cfset info.description = "Transfer ORM's main focus is to automate the repetitive tasks of creating the SQL and custom CFCs that are often required when developing a ColdFusion application. Through a central configuration file Transfer knows how to generate objects, and how to manage them and their relationships back to the database."/>
		<cfset info.author = "Mark Mandel"/>
		<cfset info.codename = ""/>
		<cfset info.video = ""/>
		<cfset info.image = "#arguments.provider.url#assets/images/transfer.jpg"/>
		<cfset info.support = ""/>
		<cfset info.documentation = "http://docs.transfer-orm.com/"/>
		<cfset info.forum = ""/>
		<cfset info.mailinglist = "http://groups.google.com/group/transfer-dev"/>
		<cfset info.network = ""/>
		<cfset info.created = parseDateTime("@extensionTimestamp@")/>
		<cfset info.version = "@extensionVersion@"/>
		<cfset info.category = "ORM Library"/>
		<cfset info.download = "#arguments.provider.url#extensions/#info.name#-#info.version#-railo-extension.zip"/>
		<cfreturn info/>
	</cffunction>
</cfcomponent>
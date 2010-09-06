<cfcomponent output="false">

	<cfset this.COLUMNS = "type,id,name,label,description,version,category,image,download,author,codename,video,support,documentation,forum,mailinglist,network,created,size,package"/>

	<cffunction name="getInfo" returntype="struct" access="private" output="false">
		<cfset var info = structNew()/>

		<cfset info.id = ""/>
		<cfset info.name = ""/>
		<cfset info.type = ""/>
		<cfset info.label = ""/>
		<cfset info.description = ""/>
		<cfset info.author = ""/>
		<cfset info.codename = ""/>
		<cfset info.video = ""/>
		<cfset info.image = ""/>
		<cfset info.support = ""/>
		<cfset info.documentation = ""/>
		<cfset info.forum = ""/>
		<cfset info.mailinglist = ""/>
		<cfset info.network = ""/>
		<cfset info.created = now()/>
		<cfset info.version = ""/>
		<cfset info.category = ""/>
		<cfset info.download = ""/>
		<cfset info.size = ""/>
		<cfreturn info/>
	</cffunction>

	<cffunction name="getFileSize" returntype="string" access="private" output="false">
		<cfargument name="file" type="string" required="false" default=""/>

		<cfset var f = ""/>
		<cfset var b = ""/>
		<cfset var size = ""/>
		<cfset var units = {b=1, k=1024, m=1048576, g=1073741824}/>

		<cfif not fileExists(arguments.file)>
			<cfreturn size/>
		</cfif>

		<cfset f = createObject("java", "java.io.File").init(arguments.file)/>
		<cfset b = f.length()/>
		<cfif b lt units.k>
			<cfset size = b & " bytes"/>
		<cfelseif b lt units.m>
			<cfset size = numberFormat(b / units.k, "999.0") & " Kb"/>
		<cfelseif b lt units.g>
			<cfset size = numberFormat(b / units.m, "999.0") & " Mb"/>
		<cfelse>>
			<cfset size = numberFormat(b / units.g, "999.0") & " Gb"/>
		</cfif>
		<cfreturn size/>
	</cffunction>

</cfcomponent>
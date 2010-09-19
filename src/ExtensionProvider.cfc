<cfcomponent output="false">

	<cffunction name="getInfo" returntype="struct" access="remote" output="false">
		<cfset var info = {}/>

		<cfset info.title = "Lamoree Software (www.lamoree.com)"/>
		<cfset info.description = ""/>
		<cfset info.url = "@providerURL@"/>
		<cfset info.image = "#info.url#assets/images/lamoree-software-logo.png"/>
		<cfset info.mode = "@providerMode@"/>
		<cfset info.path = getDirectoryFromPath(getMetadata(this).path)/>
		<cfreturn info/>
	</cffunction>

	<cffunction name="listApplications" returntype="query" access="remote" output="false">
		<cfset var provider = getInfo()/>
		<cfset var columns = createObject("component", "extensions.BaseExtension").COLUMNS/>
		<cfset var extensions = queryNew(columns)/>
		<cfset var extension = "null"/>
		<cfset var paths = "null"/>
		<cfset var results = "null"/>

		<cfdirectory action="list" directory="#provider.path#extensions/" name="paths" recurse="false" type="dir" listinfo="name"/>
		<cfloop query="paths">
			<cfset extension = getExtension("extensions.#paths.name#.Extension")/>
			<cfset queryAppend(extensions, extension.getInfo(provider))/>
		</cfloop>

		<cfquery name="results" dbtype="query">
			SELECT *
			FROM extensions
			ORDER BY category, label
		</cfquery>
		<cfreturn results/>
	</cffunction>

	<cffunction name="getDownloadDetails" returntype="struct" access="remote" output="false">
		<cfargument name="type" required="true" type="string"/>
		<cfargument name="serverId" required="true" type="string"/>
		<cfargument name="webId" required="true" type="string"/>
		<cfargument name="appId" required="true" type="string"/>

		<cfset var provider = getInfo()/>
		<cfset var apps = listApplications()/>
		<cfset var lookup = "null"/>
		<cfset var data = {error=true, message="", url=""}/>

		<cfquery name="lookup" dbtype="query">
			SELECT *
			FROM apps
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.appId#"/>
		</cfquery>
		<cfif not lookup.recordCount eq 1>
			<cfset data.message = "Could not locate application requested."/>
			<cfreturn data/>
		</cfif>
		<cfset data.error = false/>
		<cfset data.url = lookup.download>
		<cfreturn data/>
	</cffunction>

	<cffunction name="getExtension" returntype="any" access="private" output="false">
		<cfargument name="name" type="string" required="true"/>

		<cftry>
			<cfreturn createObject("component", arguments.name)/>
			<cfcatch>
				<cfthrow type="#cfcatch.type#" message="Could not create #arguments.name# extension." detail="#cfcatch.detail#"/>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="queryAppend" returntype="void" access="private" output="false">
		<cfargument name="query" type="query" required="true"/>
		<cfargument name="struct" type="struct" required="true"/>

		<cfset var c = ""/>
		<cfset var q = arguments.query/>
		<cfset var s = arguments.struct/>

		<cfset queryAddRow(q)/>
		<cfloop list="#q.columnList#" index="c">
			<cfset querySetCell(q, c, s[c])/>
		</cfloop>
	</cffunction>

</cfcomponent>
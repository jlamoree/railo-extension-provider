<cfcomponent extends="InstallSupport">

	<cfset variables.displayPathMode = false/>

	<cffunction name="validate" returntype="void" output="false">
		<cfargument name="error" type="struct"/>
		<cfargument name="path" type="string"/>
		<cfargument name="config" type="struct"/>
		<cfargument name="step" type="numeric"/>

		<cfset var data = arguments.config.mixed/>

		<cfif directoryExists(data.path) and data.pathMode eq "error">
			<cfset arguments.error.fields.path = "The #data.path# directory already exists."/>
			<cfset variables.displayPathMode = true/>
		</cfif>
	</cffunction>

	<cffunction name="install" returntype="string" output="false">
		<cfargument name="error" type="struct"/>
		<cfargument name="path" type="string"/>
		<cfargument name="config" type="struct"/>

		<cfset var data = arguments.config.mixed/>
		<cfset var buffer = createObject("java", "java.lang.StringBuffer")/>
		<cfset var backup = ""/>

		<!--- do path --->
		<cfif data.pathMode eq "error">
			<cfset unzip(zip="#arguments.path#content.zip", destination=data.path)>
	 	<cfelseif data.pathMode eq "replace">
			<cfset backup = getBackupPath(data.path)/>
			<cfdirectory action="rename" directory="#data.path#" newdirectory="#backup#"/>
			<cfset unzip(zip="#path#content.zip", destination=data.path)/>
			<cfset buffer.append("<br>- backup existing folder to [#backup#]")/>
		<cfelseif data.pathMode eq "overwrite">
			<cfset backup = getBackupPath(data.path)/>
			<cfset unzip(zip="#path#content.zip", destination=backup)/>
			<cfset copyChildren(backup, data.path)/>
			<cfdirectory directory="#backup#" action="delete" recurse="yes"/>
		</cfif>

		<!--- create mapping --->
		<cfif data.createMapping eq true>
			<cfset updateMapping(virtual="/#variables.appName#", physical=data.path)/>
			<cfset buffer.append("<br>- created mapping [#variables.appName#]")/>
		</cfif>
		<cfset buffer.append("<br>- copied files to [#data.path#]")/>
		<cfreturn "<b>#variables.appName# is now successfully installed</b>" & buffer.toString()/>
	</cffunction>


	<cffunction name="copyChildren" returntype="string" output="false">
		<cfargument name="from" type="string">
		<cfargument name="to" type="string">

		<cfset var dir = ""/>

		<cfif directoryExists(arguments.from)>
			<cfif not directoryExists(arguments.to)>
				<cfdirectory directory="#arguments.to#" action="create" mode="777"/>
			</cfif>
			<cfdirectory directory="#arguments.from#" action="list" name="dir" recurse="no">
			<cfloop query="dir">
				<cfset copyChildren("#arguments.from#/#dir.name#", "#arguments.to#/#dir.name#")/>
			</cfloop>
		<cfelseif fileExists(arguments.from)>
			<cffile action="move" source="#arguments.from#" destination="#arguments.to#" nameconflict="overwrite"/>
		</cfif>
	</cffunction>


	<cffunction name="getBackupPath" returntype="string" output="false">
		<cfargument name="path" type="string">

		<cfset var info = getFileInfo(arguments.path)/>
		<cfset var backup = "#info.parent#/backup_#info.name#"/>
		<cfset var i = 0/>

		<cfif not directoryExists(backup)>
			<cfreturn backup/>
		</cfif>

		<cfloop index="i" from="1" to="10000">
			<cfset backup = "#info.parent#/backup_#info.name#_#i#">
			<cfif not directoryExists(backup)>
				<cfreturn backup/>
			</cfif>
		</cfloop>
		<cfthrow message="A valid backup path could not be created."/>
	</cffunction>

	<cffunction name="update" returntype="string" output="false">
		<cfreturn install(argumentCollection=arguments)/>
	</cffunction>


	<cffunction name="fillMapping" output="false">
		<cfargument name="item" type="component">

		<cfset item.setValue("/#variables.appName#")>
	</cffunction>

	<cffunction name="fillPath" output="false">
		<cfargument name="item" type="component">

		<cfset item.setValue(expandPath("{web-root-directory}/#variables.appName#-#variables.version#/"))>
	</cffunction>

	<cffunction name="fillPathMode" output="false">
		<cfargument name="group" type="component">

		<cfif variables.displayPathMode>
			<cfset item = group.createItem(type="radio", name="pathMode", label="")>
			<cfset item.createOption(value="error", label="throw error", description="throw an error if the target folder already exists", selected=true)>
			<cfset item.createOption(value="overwrite", label="overwrite folder", description="overwrite existing files in the target folder. Other files in this folder are not touched.")>
			<cfset item.createOption(value="replace", label="replace folder", description="rename the existing folder and copy the new files in the target folder")>
		<cfelse>
			<cfset item = group.createItem(type="hidden", name="pathMode", value="error")>
		</cfif>
	</cffunction>


	<cffunction name="uninstall" returntype="string" output="false">
		<cfargument name="path" type="string">
		<cfargument name="config" type="struct">

		<cfset var data = arguments.config.mixed/>
		<cfset var errors = arrayNew(1)/>

		<!--- remove files --->
		<cftry>
			<cfdirectory directory="#data.path#" action="delete" recurse="yes"/>
			<cfcatch>
				<cfset arrayAppend(errors, cfcatch)/>
			</cfcatch>
		</cftry>

		<!--- remove mapping --->
		<cftry>
			<cfset removeMapping("/#variables.appName#")/>
			<cfcatch>
				<cfset arrayAppend(errors, cfcatch)/>
			</cfcatch>
		</cftry>

		<cfset throwErrors(errors)/>
		<cfreturn "#variables.appName# sucessfully removed"/>
	</cffunction>
</cfcomponent>
<cfcomponent>
	
    <cffunction name="updateMapping" returntype="string" output="no"
    	hint="creates a mapping">
    	<cfargument name="virtual" type="string" required="yes">
        <cfargument name="physical" type="string" required="no" default="">
        <cfargument name="archive" type="string" required="no" default="">
        <cfargument name="primary" type="string" required="no" default="physical">
        <cfargument name="trusted" type="boolean" required="no" default="#false#">
        <cfargument name="toplevel" type="boolean" required="no" default="#true#">
        
        <!--- create mapping --->
        <cfadmin 
            action="updateMapping"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            
            virtual="#arguments.virtual#"
            physical="#arguments.physical#"
            archive="#arguments.archive#"
            primary="#arguments.primary#"
            trusted="#arguments.trusted#"
            toplevel="#arguments.toplevel#">
    </cffunction>
    
    <cffunction name="unzip" returntype="string" output="no"
    	hint="unzip zip file">
    	<cfargument name="zip" type="string" required="yes">
        <cfargument name="destination" type="string" required="yes">
        
        <!--- unzip files --->
        <cfzip
            action = "unzip"
            destination = "#arguments.destination#"
            file = "#arguments.zip#"
            overwrite = "yes"
            recurse = "yes"
            storePath = "yes">
    </cffunction>
    
    
    <cffunction name="removeMapping" returntype="string" output="no"
    	hint="removw a mapping">
    	<cfargument name="virtual" type="string" required="yes">
        
        <!--- remove files --->
        <cfadmin 
            action="removeMapping"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            
            virtual="#arguments.virtual#">
        	
    </cffunction>
    
    
    
    <cffunction name="throwErrors" returntype="void" output="no"
    	hint="merge and throw the errors given">
    	<cfargument name="errors" type="array">
        
        <cfif arrayLen(errors) EQ 0>
        	<cfreturn>
        <cfelseif arrayLen(errors) EQ 1>
        	<cfthrow object="#errors[1]#">
        <cfelseif arrayLen(errors) GT 1>
        	<cfset var message="">
       		<cfset var error="">
            <cfloop array="#errors#" index="error">
            	<cfset message&=error.message&"
">
            </cfloop>
            <cfthrow message="#message#">
        </cfif>
    </cffunction>
</cfcomponent>
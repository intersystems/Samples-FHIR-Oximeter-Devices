class Setup {

/// Creates an R4 FHIR Server and foundation namespace and directs incoming FHIR requests
/// To an interoperability production
ClassMethod setUpFHIR() As %Status
{   
    set $namespace = "HSLIB"
    set baseDir = "/opt/app/"
    set status = ##class(HS.HC.Util.Installer).InstallFoundation("R4FHIRNamespace")
    $$$ThrowOnError(status)

    // Switch to newly created namespace
    set $namespace = "R4FHIRNamespace"
    do $system.OBJ.LoadDir(baseDir _ "src/Demo/", "ck")
    do $system.OBJ.LoadDir(baseDir_ "src/Solution/", "ck")

    // Install elements that are required for a FHIR-enabled namespace
    do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Declare installation configuration variables
    set tFHIRApp = "/csp/healthshare/r4fhirnamespace/fhir/r4"
    set tStrategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    set tMetadataConfigKey = "HL7v40"

    // Install an instance of a FHIR Service into the current namespace
    do ##class(HS.FHIRServer.Installer).InstallInstance(tFHIRApp, tStrategyClass, tMetadataConfigKey,"",0)

    // Configure FHIR app
    set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(tFHIRApp) 
    set configData = strategy.GetServiceConfigData() 
    set configData.DebugMode = 4   

    
    set cspApp = ##class(HS.Util.RESTCSPConfig).URLIndexOpen(tFHIRApp)
    set cspApp.ServiceConfigName = "HS.FHIRServer.Interop.Service"

    set status = cspApp.%Save()
    $$$ThrowOnError(status)

    do strategy.SaveServiceConfigData(configData)

    set status = ##class(Demo.FoundationProduction).Start()
    return status
}

/// Creates an R4 FHIR Server and foundation namespace and directs incoming FHIR requests
/// To an interoperability production. This method is specific to the online learning lab
ClassMethod setUpLearningLab() as %Status 
{
    set $namespace = "HSLIB"
    set baseDir = "/home/project/shared/Samples-FHIR-Oximeter-Devices/"

    set status = ##class(HS.HC.Util.Installer).InstallFoundation("R4FHIRNamespace")
    $$$ThrowOnError(status)

    // Switch to newly created namespace
    set $namespace = "R4FHIRNamespace"
    do $system.OBJ.LoadDir(baseDir _ "src/Demo/", "ck")
    do $system.OBJ.LoadDir(baseDir _ "src/Solution/", "ck")
    set tFHIRApp = "/csp/healthshare/r4fhirnamespace/fhir/r4"
    set tStrategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    set tMetadataConfigKey = "HL7v40"

        // Install elements that are required for a FHIR-enabled namespace
    do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Declare installation configuration variables
    set tFHIRApp = "/csp/healthshare/r4fhirnamespace/fhir/r4"
    set tStrategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    set tMetadataConfigKey = "HL7v40"

    // Install an instance of a FHIR Service into the current namespace
    do ##class(HS.FHIRServer.Installer).InstallInstance(tFHIRApp, tStrategyClass, tMetadataConfigKey,"",0)

    // Configure FHIR app
    set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(tFHIRApp) 
    set configData = strategy.GetServiceConfigData() 
    set configData.DebugMode = 4   

    
    set cspApp = ##class(HS.Util.RESTCSPConfig).URLIndexOpen(tFHIRApp)
    set cspApp.ServiceConfigName = "HS.FHIRServer.Interop.Service"

    set status = cspApp.%Save()
    $$$ThrowOnError(status)

    do strategy.SaveServiceConfigData(configData)

    set status = ##class(Demo.FoundationProduction).Start()
    return status
}

}
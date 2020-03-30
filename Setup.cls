class Setup {

ClassMethod setUpFHIR() As %Status
{
    zn "HSLIB"
    set status = ##class(HS.HC.Util.Installer).InstallFoundation("FHIRNamespace")
    set $namespace = "FHIRNamespace"
    Set tFHIRApp = "/csp/healthshare/fhirnamespace/fhir/r4"
    Set tStrategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    Set tMetadataConfigKey = "HL7v40"

    // Install elements that are required for a FHIR-enabled namespace
    Do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Install an instance of a FHIR Service into the current namespace
    Do ##class(HS.FHIRServer.Installer).InstallInstance(tFHIRApp, tStrategyClass, tMetadataConfigKey,"",0)

    Set appKey = "/csp/healthshare/fhirnamespace/fhir/r4"
    Set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(appKey) 
    Set configData = strategy.GetServiceConfigData() 
    Set configData.DebugMode = 4
    #; set configData.ServiceConfigName = "HS.FHIRServer.Interop.Service"
    do $system.OBJ.LoadDir("/opt/app/src/Demo/", "ck")
    do $system.OBJ.LoadDir("/opt/app/src/FHIRNAMESPACEPKG/", "ck")
    do ##class(FHIRNAMESPACEPKG.FoundationProduction).Start()
    Do $system.OBJ.Load("/opt/app/Installer.cls", "ck")
    set sc = ##class(App.Installer).setup()
    set cspApp = ##class(HS.Util.RESTCSPConfig).URLIndexOpen(appKey)
    set cspApp.ServiceConfigName = "HS.FHIRServer.Interop.Service"
    set st = cspApp.%Save()
    if $$$ISERR(st) {
        write "something went wrong"
    }
    Do strategy.SaveServiceConfigData(configData)
    return sc
}

}
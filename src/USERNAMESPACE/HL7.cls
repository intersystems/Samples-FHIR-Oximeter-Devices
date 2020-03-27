Class Demo.HL7 Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Demo.HL7" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="From_Fhir" Category="" ClassName="EnsLib.HL7.Service.HTTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.5</Setting>
    <Setting Target="Host" Name="TargetConfigNames">From_Fhir_Router</Setting>
    <Setting Target="Adapter" Name="Port">9980</Setting>
  </Item>
  <Item Name="From_Fhir_Router" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Demo.FromFhirRoutingRule</Setting>
  </Item>
</Production>
}

}

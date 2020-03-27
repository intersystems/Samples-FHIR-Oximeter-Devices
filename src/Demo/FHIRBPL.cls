/// 
Class Demo.FHIRBPL Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='HS.FHIRServer.Interop.Request' response='HS.FHIRServer.Interop.Response' height='2000' width='2000' >
<context>
<property name='O2Sat' type='%Integer' instantiate='0' />
<property name='Payload' type='%DynamicObject' instantiate='0' />
<property name='Schedule' type='HS.FHIR.vSTU3.Model.Resource.Schedule' instantiate='0' />
</context>
<sequence xend='200' yend='1000' >
<call name='Call Operation' target='HS.FHIRServer.Interop.Operation' async='0' xpos='200' ypos='250' >
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<code xpos='200' ypos='350' >
<![CDATA[
  if ((request.Request.RequestMethod="POST") & (request.Request.RequestPath="Observation")){
    set stream = ##class(HS.SDA3.QuickStream).%OpenId(request.QuickStreamId)
    set Json = ##class(%DynamicObject).%FromJSON(stream)
    set context.O2Sat = Json.valueQuantity.value
   
 }]]>
</code>
<trace name='trace' value='context.O2Sat' xpos='200' ypos='450' />
<if name='Check O2 Levels' condition='context.O2Sat &lt; 90' xpos='200' ypos='550' xend='200' yend='900' >
<true>
<transform name='trasform to send' class='Demo.FHIRObosSIUS12' source='context.Payload' target='context.Schedule' xpos='335' ypos='700' />
<call name='To Scheduling Service' target='To_Scheduling' async='1' xpos='335' ypos='800' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.Schedule" action="set" />
</request>
<response type='Ens.Response' />
</call>
</true>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}

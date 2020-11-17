/// 
Class Solution.FHIRBPL Extends Ens.BusinessProcessBPL
{



/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='HS.FHIRServer.Interop.Request' response='HS.FHIRServer.Interop.Response' height='2000' width='2000' >
<context>
<property name='O2Sat' type='%Integer' instantiate='0' />
<property name='Schedule' type='EnsLib.HL7.Message' instantiate='0' />
</context>
<sequence xend='200' yend='1150' >
<call name='Call Operation' target='HS.FHIRServer.Interop.Operation' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[Pass FHIR requests onto FHIR server for CRUD operations]]></annotation>
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<code name='Get O2 Data' xpos='200' ypos='350' >
<annotation><![CDATA[Unpack FHIR payload and expose the oxygen saturation in the context variable O2Sat]]></annotation>
<![CDATA[

  // Process the FHIR data if the request method is POST and the Resource is an Observation
  if (request.Request.RequestMethod="POST") && (request.Request.RequestPath="Observation"){


    // FHIR data comes in as a Quickstream object, which is like a BLOB
    // It must be read into a string before it can be handled
    // Start by opening the Quickstream object whose ID is part of the request.
    set quickStream = ##class(HS.SDA3.QuickStream).%OpenId(request.QuickStreamId)

    // Read that stream into a Dynamic object, which can represent
    // JSON data
    set Observation = ##class(%DynamicObject).%FromJSON(quickStream)

    // Access the oxygen saturation value and place it in a local 
    // Context variable.
    set context.O2Sat = Observation.valueQuantity.value
   
 }]]>
</code>
<if name='Check O2 Levels' condition='context.O2Sat &amp;&amp; (context.O2Sat &lt; 90) ' xpos='335' ypos='600' xend='335' yend='950' >
<true>
<transform name='Trasform to send' class='Solution.FromFhirObsToSIUS12' source='context' target='context.Schedule' xpos='470' ypos='750' />
<call name='To Scheduling Service' target='To_Scheduling' async='1' xpos='470' ypos='850' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.Schedule" action="set" />
</request>
</call>
</true>
</if>
</sequence>
</process>
}

}

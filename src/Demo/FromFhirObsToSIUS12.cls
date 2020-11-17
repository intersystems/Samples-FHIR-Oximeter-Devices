Class Demo.FromFhirObsToSIUS12 Extends Ens.DataTransformDTL [ DependsOn = (HS.FHIRServer.Storage.Json.Resource, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIRServer.Storage.Json.Resource' targetClass='EnsLib.HL7.Message' targetDocType='2.5:SIU_S12' create='new' language='objectscript' >
<assign value='"MSH|^~\&amp;|EPIC|EPIC|||20160502162033||SIU^S12|538|D|2.3||"' property='target.{MSH}' action='set' >
<annotation>create an HL7 SIU_12 message and set the MSH segment to the string value listed above</annotation>
</assign>
<assign value='"SCH|01928374|57483920|||||||1|hr|1^^^20160515133000|||||||||1173^MATTHEWS^JAMES^A|||||BOOKED"' property='target.{SCH}' action='set' >
<annotation>Construct the SCH section and fill in the fields with generic data. In a real implementation, the process would first match the patient to their provider, then populate this message with that information.</annotation>
</assign>
<assign value='"RGS|1|A|094"' property='target.{RGSgrp(1).RGS}' action='set' >
<annotation>Again, a generic message segment for the sake of simplicity.</annotation>
</assign>
</transform>
}

}

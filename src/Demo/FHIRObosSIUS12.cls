Class Demo.FHIRObosSIUS12 Extends Ens.DataTransformDTL [ DependsOn = (HS.FHIR.vSTU3.Model.Resource.Observation, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.vSTU3.Model.Resource.Observation' targetClass='EnsLib.HL7.Message' targetDocType='2.5:SIU_S12' create='new' language='objectscript' >
<assign value='"MSH|^~\&amp;|EPIC|EPIC|||20160502162033||SIU^S12|538|D|2.3||"' property='target.{MSH}' action='set' />
<assign value='"SCH|01928374|57483920|||||||1|hr|1^^^20160515133000|||||||||1173^MATTHEWS^JAMES^A|||||BOOKED"' property='target.{SCH}' action='set' />
<assign value='git' property='target.{RGSgrp(1).RGS}' action='set' />
</transform>
}

}

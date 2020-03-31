/// 
Class Solution.CallScheduling Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="Solution.FoundationProduction">
<ruleSet name="Check O2" effectiveBegin="" effectiveEnd="">
<rule name="Check O2" disabled="false">
<when condition="O2Sat&lt;90">
<send transform="Demo.FHIRObsToScheduleService" target="To_Scheduling"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}

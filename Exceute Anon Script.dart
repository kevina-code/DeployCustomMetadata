/**
 * execute anonymous code to efficiently create Trigger_Handler_Bypass__mdt records
 *  for all your non-managed trigger handlers
 */
// add all your non-managed trigger handler names to this set:
Set<String> triggerHandlers = new Set<String>();
triggerHandlers.add('MyTriggerHandler1');
triggerHandlers.add('MyTriggerHandler2');
triggerHandlers.add('MyTriggerHandler3');
//... and so on...

for(String triggerHandler : triggerHandlers) {
    Map<String, Object> metadataFieldValueMap = new Map<String, Object>();
	metadataFieldValueMap.put('Some_Field__c', 'some value'); 
	CustomMetadataUtils.createCustomMetadata('Some_Custom_Metadata_Obj__mdt', triggerHandler, metadataFieldValueMap);
}


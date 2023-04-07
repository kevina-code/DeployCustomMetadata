# DeployCustomMetadata

Execute anonymous code to efficiently create Trigger_Handler_Bypass__mdt records  for all your non-managed trigger handlers so you don't have to do it manually in the Salesforce UI:

```java
// add all your non-managed trigger handler names to this set:
Set<String> triggerHandlers = new Set<String>();
triggerHandlers.add('MyTriggerHandler9');
triggerHandlers.add('MyTriggerHandler99');
triggerHandlers.add('MyTriggerHandler999');
//... and so on...

List<Metadata.CustomMetadata> allMetadatas = new List<Metadata.CustomMetadata>();
for(String triggerHandler : triggerHandlers) {
    allMetadatas.add(DeployCustomMetadata.createMetadataInstance('Trigger_Handler_Bypass', triggerHandler, triggerHandler, new Map<String, Object>{'Active__c'=> false}));
}
DeployCustomMetadata.deployMetadata(allMetadatas);
```

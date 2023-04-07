# DeployCustomMetadata

Execute anonymous code to efficiently create Trigger_Handler_Bypass__mdt records  for all your non-managed trigger handlers so you don't have to do it manually in the Salesforce UI:

```java
// add all your non-managed trigger handler names to this set:
Set<String> triggerHandlers = new Set<String>();
triggerHandlers.add('MyTriggerHandler1');
triggerHandlers.add('MyTriggerHandler2');
triggerHandlers.add('MyTriggerHandler3');
//... and so on...

for(String triggerHandler : triggerHandlers) {
    List<Metadata.CustomMetadata> allMetadatas = new List<Metadata.CustomMetadata>();
    allMetadatas.add(DeployCustomMetadata.createMetadataInstance('Trigger_Handler_Bypass', triggerHandler, triggerHandler, new Map<String, Object>             {'Active__c'=> false}));
    DeployCustomMetadata.deployMetadata(allMetadatas);
}
```

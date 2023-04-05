/**
 * Usage example (execute anon code):
 * Map<String, Object> metadataFieldValueMap = new Map<String, Object>();
 * metadataFieldValueMap.put('Active__c', false);
 * CustomMetadataUtils.createCustomMetadata('Your_CustomMedata_Type__mdt', 'Desired Label Name', metadataFieldValueMap);
 */
public class CustomMetadataUtils implements Metadata.DeployCallback {
  //Inteface method
  public void handleResult(
    Metadata.DeployResult result,
    Metadata.DeployCallbackContext context
  ) {
    if (result.status == Metadata.DeployStatus.Succeeded) {
      //Success
      System.debug('Success Result-' + result);
    } else {
      //Failed
      System.debug('Failed Result-' + result);
    }
  }

  //Create Custom Metadata record
  public static void createCustomMetadata(
    String metadataName,
    String label,
    Map<String, Object> metadataFieldValueMap
  ) {
    String recordDevName = label.replaceAll(' ', '_');
    Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
    cMetadata.fullName = metadataName + '.' + recordDevName;
    cMetadata.label = label;

    for (String key : metadataFieldValueMap.keySet()) {
      Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
      cMetadataValue.Field = key;
      cMetadataValue.Value = metadataFieldValueMap.get(key);
      cMetadata.values.add(cMetadataValue);
    }

    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
    mdContainer.addMetadata(cMetadata);
    CustomMetadataUtils callback = new CustomMetadataUtils();
    Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
  }

  //Update Custom Metadata record
  public static void updateCustomMetadata(
    String metadataName,
    String recordDevName,
    String label,
    Map<String, Object> metadataFieldValueMap
  ) {
    Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
    cMetadata.fullName = metadataName + '.' + recordDevName;
    cMetadata.label = label;

    for (String key : metadataFieldValueMap.keySet()) {
      Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
      cMetadataValue.Field = key;
      cMetadataValue.Value = metadataFieldValueMap.get(key);
      cMetadata.values.add(cMetadataValue);
    }

    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
    mdContainer.addMetadata(cMetadata);
    CustomMetadataUtils callback = new CustomMetadataUtils();
    Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
  }
}

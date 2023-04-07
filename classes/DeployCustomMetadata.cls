/**
 * DeployCustomMetadta helps creating Custom Metadata using APEX directly.
 *
 * @author    Darshan Farswan
 * @version   1.0
 * @since     2020-03-29
 */
public with sharing class DeployCustomMetadata {
  /**
   * createMetadataInstance method creates the instance of Metadata.CustomMetadata
   * The method takes four parameters
   * @param API Name of the Custom Metadata Type
   * @param metadataLabel Label of the Custom Metadata
   * @param metadataName  API Name of the Custom Metadata
   * @return fieldValuesMap Map to store the Custom Metadata custom fields and their values
   */
  public static Metadata.CustomMetadata createMetadataInstance(
    String customMetadataType,
    String metadataLabel,
    String metadataName,
    Map<String, Object> fieldValuesMap
  ) {
    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    customMetadata.label = metadataLabel;
    customMetadata.fullName =
      customMetadataType.removeEnd('__mdt') +
      '.' +
      metadataName;
    for (String fieldKey : fieldValuesMap.keySet()) {
      Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
      customField.field = fieldKey;
      customField.value = fieldValuesMap.get(fieldKey);
      customMetadata.values.add(customField);
    }
    return customMetadata;
  }

  /**
   * deployMetadata method runs the deployment to create/update the Custom Metadata Records
   * @param customMetadataRecords List of Custom Metadata records
   */
  public static Id deployMetadata(
    List<Metadata.CustomMetadata> customMetadataRecords
  ) {
    Id deploymentId = null;
    Metadata.DeployContainer metadataDeployContainer = new Metadata.DeployContainer();
    for (Metadata.CustomMetadata customMetadata : customMetadataRecords) {
      metadataDeployContainer.addMetadata(customMetadata);
    }

    //Queue the deployment. The deployment takes the Metadata.DeployContainer record and callback instance.
    //We can use instance of a class that implements Metadata.DeployCallback, but as we are not handling the
    //results, we will use null as second parameter
    if (!Test.isRunningTest()) {
      deploymentId = Metadata.Operations.enqueueDeployment(
        metadataDeployContainer,
        null
      );
    }
    return deploymentId;
  }
}
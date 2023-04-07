/**
 * Test class for DeployCustomMetadata.cls
 *
 * @author    Darshan Farswan
 * @version   1.0
 * @since     2020-03-29
 */
@isTest
public with sharing class DeployCustomMetadataTest {
  /**
   * Unit test method for createMetadataInstance mehthod in DeployCustomMetadata class.
   * The test method verifies that the Custom Metadata record is instantiated successfully
   */
  @isTest
  public static void createMetadataInstanceTest() {
    String customMetadataType = 'Org_Setting';
    String metadataLabel = 'Default Country';
    String metadataName = 'Default_Country';
    Map<String, Object> fieldValuesMap = new Map<String, Object>{
      'Value__c' => 'India'
    };

    Test.startTest();

    Metadata.CustomMetadata customMetadataInstance = DeployCustomMetadata.createMetadataInstance(
      customMetadataType,
      metadataLabel,
      metadataName,
      fieldValuesMap
    );

    Test.stoptest();

    System.assertEquals(metadataLabel, customMetadataInstance.label);
    System.assertEquals(
      customMetadataType +
      '.' +
      metadataName,
      customMetadataInstance.fullName
    );
  }

  /**
   * Unit test method for deployMetadata mehthod in DeployCustomMetadata class.
   * As deployments cannot happen in test class, we simply expect to get null Id returned
   */
  @isTest
  public static void deployMetadataTest() {
    String customMetadataType = 'Org_Setting';
    String metadataLabel = 'Default Country';
    String metadataName = 'Default_Country';
    Map<String, Object> fieldValuesMap = new Map<String, Object>{
      'Value__c' => 'India'
    };

    List<Metadata.CustomMetadata> customMetadataInstanceRecords = new List<Metadata.CustomMetadata>();
    customMetadataInstanceRecords.add(
      DeployCustomMetadata.createMetadataInstance(
        customMetadataType,
        metadataLabel,
        metadataName,
        fieldValuesMap
      )
    );

    Test.startTest();

    Id deploymentId = DeployCustomMetadata.deployMetadata(
      customMetadataInstanceRecords
    );

    Test.stoptest();

    System.assertEquals(null, deploymentId);
  }
}

@isTest
private class AssetTriggerHandlerTest {

    @isTest
    static void testAssetBeforeInsertSetsDefaults() {
        // Arrange
        Asset assetWithoutValues = new Asset();
        // You must provide AccountId or ContactId (required by Salesforce)
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        assetWithoutValues.AccountId = acc.Id;

        // Act
        Test.startTest();
        insert assetWithoutValues;
        Test.stopTest();

        // Assert
        Asset insertedAsset = [SELECT Name, Status FROM Asset WHERE Id = :assetWithoutValues.Id];
        System.assertEquals('New Asset', insertedAsset.Name, 'Default Name should be set');
        System.assertEquals('Active', insertedAsset.Status, 'Default Status should be set');
    }

    @isTest
    static void testAssetBeforeInsertWithValues() {
        // Arrange
        Account acc = new Account(Name = 'Existing Account');
        insert acc;

        Asset assetWithValues = new Asset(
            Name = 'Existing Asset',
            Status = 'Installed',
            AccountId = acc.Id
        );

        // Act
        Test.startTest();
        insert assetWithValues;
        Test.stopTest();

        // Assert
        Asset insertedAsset = [SELECT Name, Status FROM Asset WHERE Id = :assetWithValues.Id];
        System.assertEquals('Existing Asset', insertedAsset.Name);
        System.assertEquals('Installed', insertedAsset.Status);
    }
}

@isTest
private class AssetTriggerHandlerTest {

    @isTest
    static void testBeforeInsertSetsDefaults() {
        // Arrange
        Asset a = new Asset(
            Name = null,
            Status = null,
            AccountId = null
        );

        Test.startTest();
        insert a;
        Test.stopTest();

        // Assert
        Asset inserted = [SELECT Id, Name, Status FROM Asset WHERE Id = :a.Id];
        System.assertEquals('New Asset', inserted.Name, 'Name should default to New Asset');
        System.assertEquals('Active', inserted.Status, 'Status should default to Active');
    }
}
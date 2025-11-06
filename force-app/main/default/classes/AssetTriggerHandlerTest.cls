@isTest
private class AssetTriggerHandlerTest {

    @isTest
    static void testBeforeInsertSetsDefaults() {
        // Arrange
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create asset linked to account (required)
        Asset a = new Asset(
            Name = null,
            Status = null,
            AccountId = acc.Id
        );

        Test.startTest();
        insert a; // Fires AssetTrigger → AssetTriggerHandler
        Test.stopTest();

        // Assert
        Asset inserted = [SELECT Id, Name, Status, AccountId FROM Asset WHERE Id = :a.Id];
        System.assertEquals('New Asset', inserted.Name, 'Name should default to New Asset');
        System.assertEquals('Active', inserted.Status, 'Status should default to Active');
        System.assertEquals(acc.Id, inserted.AccountId, 'Asset should be linked to the test account');
    }
}

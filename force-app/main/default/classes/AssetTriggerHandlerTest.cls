@isTest
private class AssetTriggerHandlerTest {
    @isTest
    static void testAssetTriggerHandler() {
        // Create test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create an Asset record that fires the trigger
        Asset ast = new Asset(
            Name = 'Test Asset',
            AccountId = acc.Id
        );

        Test.startTest();
        insert ast;
        Test.stopTest();

        // Optional: Query to confirm the record was inserted
        Asset insertedAsset = [SELECT Id, AccountId FROM Asset WHERE Id = :ast.Id];
        System.assertNotEquals(null, insertedAsset);
    }
}

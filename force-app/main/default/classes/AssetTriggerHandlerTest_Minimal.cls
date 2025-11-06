@isTest
private class AssetTriggerHandlerTest_Minimal {

    @testSetup
    static void setupData() {
        // Asset requires AccountId
        Account acc = new Account(Name = 'Test Account');
        insert acc;
    }

    @isTest
    static void testHandlerCoverage() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        // Insert one Asset with no Name or Status to cover default logic
        Asset a = new Asset(AccountId = acc.Id);

        Test.startTest();
        insert a; // Fires trigger -> AssetTriggerHandler.run()
        Test.stopTest();

        // Assert that defaults were applied
        Asset inserted = [SELECT Name, Status FROM Asset WHERE Id = :a.Id];
        System.assertEquals('Active', inserted.Status);
        System.assertEquals('New Asset', inserted.Name);
    }
}

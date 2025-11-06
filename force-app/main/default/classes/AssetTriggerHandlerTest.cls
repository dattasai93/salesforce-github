@isTest
private class AssetTriggerHandlerTest {

    @testSetup
    static void setupData() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
    }

    @isTest
    static void testDefaultsApplied() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        Asset a = new Asset(AccountId = acc.Id); // no Name or Status
        insert a; // Fires trigger

        Asset inserted = [SELECT Name, Status FROM Asset WHERE Id = :a.Id];
        System.assertEquals('Active', inserted.Status);
        System.assertEquals('New Asset', inserted.Name);
    }
}

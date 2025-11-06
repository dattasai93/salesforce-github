@isTest
private class AssetTriggerHandlerTest {

    @testSetup
    static void setupData() {
        // Required: Asset needs AccountId
        Account acc = new Account(Name = 'Test Account');
        insert acc;
    }

    @isTest
    static void testDefaultsApplied() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        Asset a = new Asset(AccountId = acc.Id); // no Name or Status

        Test.startTest();
        insert a; // Fires trigger
        Test.stopTest();

        Asset inserted = [SELECT Name, Status FROM Asset WHERE Id = :a.Id];
        System.assertEquals('Active', inserted.Status);
        System.assertEquals('New Asset', inserted.Name);
    }

    @isTest
    static void testValuesPreserved() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        Asset a = new Asset(
            AccountId = acc.Id,
            Name = 'Custom Name',
            Status = 'Inactive'
        );

        Test.startTest();
        insert a; // Fires trigger
        Test.stopTest();

        Asset inserted = [SELECT Name, Status FROM Asset WHERE Id = :a.Id];
        System.assertEquals('Inactive', inserted.Status);
        System.assertEquals('Custom Name', inserted.Name);
    }

    @isTest
    static void testMultipleAssets() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        Asset a1 = new Asset(AccountId = acc.Id);
        Asset a2 = new Asset(AccountId = acc.Id, Name = 'Predefined Name');

        List<Asset> assets = new List<Asset>{a1, a2};

        Test.startTest();
        insert assets;
        Test.stopTest();

        Asset inserted1 = [SELECT Name, Status FROM Asset WHERE Id = :a1.Id];
        Asset inserted2 = [SELECT Name, Status FROM Asset WHERE Id = :a2.Id];

        System.assertEquals('New Asset', inserted1.Name);
        System.assertEquals('Active', inserted1.Status);
        System.assertEquals('Predefined Name', inserted2.Name);
        System.assertEquals('Active', inserted2.Status);
    }
}

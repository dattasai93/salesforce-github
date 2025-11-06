@isTest
private class AssetTriggerHandlerTest {

    @testSetup
    static void setupData() {
        // Required for Asset: Account
        Account acc = new Account(Name = 'Test Account');
        insert acc;
    }

    @isTest
    static void testDefaultsAreSet() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        // Asset with neither Status nor Name
        Asset a1 = new Asset(
            AccountId = acc.Id
        );

        Test.startTest();
        insert a1;
        Test.stopTest();

        Asset inserted1 = [SELECT Name, Status FROM Asset WHERE Id = :a1.Id];
        System.assertEquals('Active', inserted1.Status, 'Status default should be Active');
        System.assertEquals('New Asset', inserted1.Name, 'Name default should be New Asset');
    }

    @isTest
    static void testValuesArePreserved() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        // Asset with Status and Name already set
        Asset a2 = new Asset(
            AccountId = acc.Id,
            Name = 'Custom Asset',
            Status = 'Inactive'
        );

        Test.startTest();
        insert a2;
        Test.stopTest();

        Asset inserted2 = [SELECT Name, Status FROM Asset WHERE Id = :a2.Id];
        System.assertEquals('Inactive', inserted2.Status, 'Existing Status should not be overwritten');
        System.assertEquals('Custom Asset', inserted2.Name, 'Existing Name should not be overwritten');
    }

    @isTest
    static void testMultipleAssets() {
        Account acc = [SELECT Id FROM Account LIMIT 1];

        Asset a3 = new Asset(AccountId = acc.Id);
        Asset a4 = new Asset(AccountId = acc.Id, Name = 'Predefined Name');

        List<Asset> assets = new List<Asset>{a3, a4};

        Test.startTest();
        insert assets;
        Test.stopTest();

        Asset insertedA3 = [SELECT Name, Status FROM Asset WHERE Id = :a3.Id];
        Asset insertedA4 = [SELECT Name, Status FROM Asset WHERE Id = :a4.Id];

        System.assertEquals('New Asset', insertedA3.Name);
        System.assertEquals('Active', insertedA3.Status);
        System.assertEquals('Predefined Name', insertedA4.Name);
        System.assertEquals('Active', insertedA4.Status);
    }
}

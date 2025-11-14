@IsTest
private class MyApexClassTest {

    // -----------------------------
    // Test Setup - reusable data
    // -----------------------------
    @TestSetup
    static void setup() {
        Account acc = new Account(Name='Test Account', Industry='Technology');
        insert acc;

        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;
    }

    // -----------------------------
    // Test AssetTriggerHandler insert
    // -----------------------------
    @isTest
    static void testAssetTriggerInsert() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contact con = [SELECT Id FROM Contact LIMIT 1];

        Asset a1 = new Asset(Name='Asset1', AccountId=acc.Id, Status=null); // Status null
        Asset a2 = new Asset(Name='Asset2', ContactId=con.Id, Status='Inactive'); // Status set
        Asset a3 = new Asset(Name='Asset3'); // Missing AccountId & ContactId

        Test.startTest();
        insert new List<Asset>{a1, a2, a3};
        Test.stopTest();

        // Validate default Status and AccountId assignments
        a1 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset1'];
        a2 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset2'];
        a3 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset3'];

        System.assertEquals('Active', a1.Status, 'Status should default to Active');
        System.assertEquals('Inactive', a2.Status, 'Status should remain Inactive');
        System.assertEquals('Active', a3.Status, 'Status should default to Active');
        System.assertNotEquals(null, a3.AccountId, 'AccountId should be set by trigger');
    }

    // -----------------------------
    // Test AccountTrigger insert
    // -----------------------------
    @isTest
    static void testAccountTriggerInsert() {
        Account acc = new Account(Name='Trigger Test Account'); // Industry null

        Test.startTest();
        insert acc;
        Test.stopTest();

        acc = [SELECT Id, Industry FROM Account WHERE Id = :acc.Id];
        System.assertNotEquals(null, acc.Industry, 'Industry should be set by trigger if null');
    }

    // -----------------------------
    // Test AssetTriggerHandler bulk insert
    // -----------------------------
    @isTest
    static void testAssetTriggerBulkInsert() {
        List<Asset> bulkAssets = new List<Asset>();
        for (Integer i = 1; i <= 200; i++) {
            bulkAssets.add(new Asset(Name='BulkAsset' + i));
        }

        Test.startTest();
        insert bulkAssets;
        Test.stopTest();

        Asset first = [SELECT Status FROM Asset WHERE Name='BulkAsset1' LIMIT 1];
        System.assertEquals('Active', first.Status, 'Bulk asset should default Status to Active');
    }

    // -----------------------------
    // Test negative scenarios / exceptions
    // -----------------------------
    @isTest
    static void testExceptionHandling() {
        try {
            Asset invalidAsset = new Asset(); // Missing required fields
            insert invalidAsset;
            System.assert(false, 'Expected DmlException not thrown');
        } catch (DmlException e) {
            // Case-insensitive check for required fields in the exception message
            System.assert(
                e.getMessage().toLowerCase().contains('required') ||
                e.getMessage().toLowerCase().contains('missing'),
                'Exception should be due to missing required fields'
            );
        }
    }
}

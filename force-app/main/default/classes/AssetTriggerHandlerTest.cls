@IsTest
public class AssetTriggerHandlerTest {

    @TestSetup
    static void setup() {
        // Create test Account and Contact to associate with Assets
        Account testAcc = new Account(Name='Test Account');
        insert testAcc;

        Contact testCon = new Contact(LastName='Test Contact', AccountId=testAcc.Id);
        insert testCon;
    }

    @IsTest
    static void testBeforeInsertDefaultStatus() {
        // Fetch the test data
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contact con = [SELECT Id FROM Contact LIMIT 1];

        // Case 1: Asset with Status null and valid AccountId
        Asset a1 = new Asset(Name='Asset1', AccountId=acc.Id, Status = null);

        // Case 2: Asset with Status already set, AccountId provided
        Asset a2 = new Asset(Name='Asset2', AccountId=acc.Id, Status = 'Inactive');

        // Case 3: Asset with null AccountId but has ContactId
        Asset a3 = new Asset(Name='Asset3', ContactId=con.Id, Status = null);

        // Case 4: Asset with null AccountId and null ContactId
        Asset a4 = new Asset(Name='Asset4', Status = null);

        Test.startTest();
        insert new List<Asset>{a1, a2, a3, a4};
        Test.stopTest();

        // Validate handler logic for all assets
        a1 = [SELECT Id, Status, AccountId, ContactId FROM Asset WHERE Name='Asset1'];
        a2 = [SELECT Id, Status, AccountId, ContactId FROM Asset WHERE Name='Asset2'];
        a3 = [SELECT Id, Status, AccountId, ContactId FROM Asset WHERE Name='Asset3'];
        a4 = [SELECT Id, Status, AccountId, ContactId FROM Asset WHERE Name='Asset4'];

        // Assertions
        System.assertEquals('Active', a1.Status, 'Asset1 should default Status to Active');
        System.assertEquals('Inactive', a2.Status, 'Asset2 status should remain unchanged');
        System.assertEquals('Active', a3.Status, 'Asset3 should default Status to Active');
        System.assertEquals('Active', a4.Status, 'Asset4 should default Status to Active');
        System.assertNotEquals(null, a4.AccountId, 'Asset4 AccountId should be set by handler');
    }

    @IsTest
    static void testBulkInsert() {
        // Test bulk insert scenario to ensure trigger works for multiple records
        List<Asset> bulkAssets = new List<Asset>();
        for(Integer i = 1; i <= 200; i++) {
            bulkAssets.add(new Asset(Name='BulkAsset' + i));
        }

        Test.startTest();
        insert bulkAssets;
        Test.stopTest();

        // Verify first asset in bulk
        Asset first = [SELECT Id, Status FROM Asset WHERE Name='BulkAsset1' LIMIT 1];
        System.assertEquals('Active', first.Status, 'Bulk asset Status should default to Active');
    }
}

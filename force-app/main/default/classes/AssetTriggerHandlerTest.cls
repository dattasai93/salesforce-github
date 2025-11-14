@IsTest
public class AssetTriggerHandlerTest {

    @TestSetup
    static void setup() {
        // Create test Account and Contact
        Account acc = new Account(Name='Test Account');
        insert acc;

        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;
    }

    @IsTest
    static void testDefaultStatusAndAccount() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contact con = [SELECT Id FROM Contact LIMIT 1];

        // Case 1: Status null, AccountId provided
        Asset a1 = new Asset(Name='Asset1', AccountId=acc.Id, Status=null);

        // Case 2: Status already set
        Asset a2 = new Asset(Name='Asset2', AccountId=acc.Id, Status='Inactive');

        // Case 3: Null AccountId, has ContactId
        Asset a3 = new Asset(Name='Asset3', ContactId=con.Id, Status=null);

        // Case 4: Null AccountId and ContactId
        Asset a4 = new Asset(Name='Asset4', Status=null);

        Test.startTest();
        insert new List<Asset>{a1, a2, a3, a4};
        Test.stopTest();

        // Validate default values and assignments
        a1 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset1'];
        a2 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset2'];
        a3 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset3'];
        a4 = [SELECT Status, AccountId FROM Asset WHERE Name='Asset4'];

        System.assertEquals('Active', a1.Status);
        System.assertEquals('Inactive', a2.Status);
        System.assertEquals('Active', a3.Status);
        System.assertEquals('Active', a4.Status);
        System.assertNotEquals(null, a4.AccountId);
    }

    @IsTest
    static void testBulkInsert() {
        // Bulk insert scenario
        List<Asset> bulkAssets = new List<Asset>();
        for (Integer i = 1; i <= 200; i++) {
            bulkAssets.add(new Asset(Name='BulkAsset' + i));
        }

        Test.startTest();
        insert bulkAssets;
        Test.stopTest();

        Asset first = [SELECT Status FROM Asset WHERE Name='BulkAsset1' LIMIT 1];
        System.assertEquals('Active', first.Status);
    }
}

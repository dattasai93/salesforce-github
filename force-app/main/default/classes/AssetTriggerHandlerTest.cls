@IsTest
private class AssetTriggerHandlerTest {

    @TestSetup
    static void setup() {
        // Create a default account to avoid query issues in handler
        Account acc = new Account(Name = 'Default Account');
        insert acc;
    }

    @IsTest
    static void testBeforeInsert() {
        // Create Assets without AccountId or Status
        List<Asset> assets = new List<Asset>();
        assets.add(new Asset(Name = 'Asset 1'));
        assets.add(new Asset(Name = 'Asset 2'));

        Test.startTest();
        insert assets; // Trigger fires here
        Test.stopTest();

        // Verify default AccountId and Status are set
        for (Asset a : [SELECT Id, AccountId, Status FROM Asset WHERE Id IN :assets]) {
            System.assertNotEquals(null, a.AccountId, 'Default AccountId should be set');
            System.assertEquals('Active', a.Status, 'Default Status should be Active');
        }
    }

    @IsTest
    static void testBeforeUpdate() {
        // Insert an asset first
        Asset asset = new Asset(Name = 'Asset Update Test');
        insert asset;

        // Clear AccountId and Status to test update logic
        asset.AccountId = null;
        asset.Status = null;

        Test.startTest();
        update asset; // Trigger fires here
        Test.stopTest();

        Asset updatedAsset = [SELECT Id, AccountId, Status FROM Asset WHERE Id = :asset.Id];
        System.assertNotEquals(null, updatedAsset.AccountId, 'Default AccountId should be set on update');
        System.assertEquals('Active', updatedAsset.Status, 'Default Status should be Active on update');
    }

    @IsTest
    static void testBulkInsertAndUpdate() {
        List<Asset> assets = new List<Asset>();
        for (Integer i = 1; i <= 200; i++) {
            assets.add(new Asset(Name = 'Bulk Asset ' + i));
        }

        Test.startTest();
        insert assets; // Bulk insert
        Test.stopTest();

        // Bulk update
        for (Asset a : assets) {
            a.Status = null;
        }

        Test.startTest();
        update assets; // Bulk update
        Test.stopTest();

        // Verify all records
        for (Asset a : [SELECT Id, Status FROM Asset WHERE Id IN :assets]) {
            System.assertEquals('Active', a.Status, 'Default Status should be Active for bulk update');
        }
    }
}

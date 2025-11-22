@isTest
private class AssetTriggerTest {
    @isTest static void testAssetTrigger() {
        Account acc = new Account(Name = 'Test Account for Asset');
        insert acc;

        Product2 prod = new Product2(Name = 'Test Product', IsActive = true);
        insert prod;

        Asset asset = new Asset(Name = 'Test Asset', AccountId = acc.Id, Product2Id = prod.Id);
        insert asset; // Fires before/after insert

        asset.Status = 'Installed';
        update asset; // Fires before/after update
    }
}

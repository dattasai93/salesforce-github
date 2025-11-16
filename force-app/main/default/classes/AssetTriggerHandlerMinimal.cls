public with sharing class AssetTriggerHandlerMinimal {

    private static Id defaultAccountId;

    public static void handleBeforeInsert(List<Asset> assets) {
        initializeDefaultAccount();
        for (Asset a : assets) {
            if (a.AccountId == null && a.ContactId == null) a.AccountId = defaultAccountId;
            if (a.Status == null) a.Status = 'Active';
        }
    }

    public static void handleBeforeUpdate(List<Asset> assets) {
        initializeDefaultAccount();
        for (Asset a : assets) {
            if (a.AccountId == null && a.ContactId == null) a.AccountId = defaultAccountId;
            if (a.Status == null) a.Status = 'Active';
        }
    }

    private static void initializeDefaultAccount() {
        if (defaultAccountId == null) {
            defaultAccountId = [SELECT Id FROM Account LIMIT 1].Id;
        }
    }
}

public with sharing class AssetTriggerHandler {

    private static Id defaultAccountId;

    public static void handleBeforeInsert(List<Asset> assets) {
        if (defaultAccountId == null) {
            defaultAccountId = [SELECT Id FROM Account LIMIT 1].Id;
        }
        for (Asset a : assets) {
            if (a.AccountId == null && a.ContactId == null) a.AccountId = defaultAccountId;
            if (a.Status == null) a.Status = 'Active';
        }
    }

    public static void handleBeforeUpdate(List<Asset> assets) {
        if (defaultAccountId == null) {
            defaultAccountId = [SELECT Id FROM Account LIMIT 1].Id;
        }
        for (Asset a : assets) {
            if (a.AccountId == null && a.ContactId == null) a.AccountId = defaultAccountId;
            if (a.Status == null) a.Status = 'Active';
        }
    }
}

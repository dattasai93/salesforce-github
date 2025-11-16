public with sharing class AssetTriggerHandler {

    // Cache default AccountId per transaction
    @TestVisible
    private static Id defaultAccountId;

    // -----------------------------
    // Handle before insert
    // -----------------------------
    public static void handleBeforeInsert(List<Asset> newAssets) {
        initializeDefaultAccount();
        for (Asset a : newAssets) {
            setDefaultAccount(a);
            setDefaultStatus(a);
        }
    }
}
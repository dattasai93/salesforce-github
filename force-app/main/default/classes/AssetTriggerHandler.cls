public with sharing class AssetTriggerHandler {

    public static void run() {
        if (Trigger.isBefore && Trigger.isInsert) {
            handleBeforeInsert(Trigger.new);
        }
    }

    private static void handleBeforeInsert(List<Asset> newAssets) {
        // Fetch a default Account to assign if AccountId is missing
        Account defaultAcc = [SELECT Id FROM Account LIMIT 1];

        for (Asset a : newAssets) {
            // Default Status
            if (a.Status == null) {
                a.Status = 'Active';
            }

            // Ensure either AccountId or ContactId exists
            if (a.AccountId == null && a.ContactId == null) {
                a.AccountId = defaultAcc.Id;
            }
        }
    }
}

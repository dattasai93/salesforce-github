public with sharing class AssetTriggerHandler {

    public static void run() {
        if (Trigger.isBefore && Trigger.isInsert) {
            handleBeforeInsert(Trigger.new);
        }
    }

    private static void handleBeforeInsert(List<Asset> newAssets) {
        // Fetch default Account once (bulk-safe)
        Account defaultAcc = [SELECT Id FROM Account LIMIT 1];

        for (Asset a : newAssets) {
            // Default Status if not provided
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

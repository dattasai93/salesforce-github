public with sharing class AssetTriggerHandler {

    public static void run() {
        if (Trigger.isBefore && Trigger.isInsert) {
            handleBeforeInsert(Trigger.new);
        }
    }

    private static void handleBeforeInsert(List<Asset> newAssets) {
        for (Asset a : newAssets) {
            if (a.Status == null) {
                a.Status = 'Active';
            }
            if (a.Name == null) {
                a.Name = 'New Asset';
            }
        }
    }
}

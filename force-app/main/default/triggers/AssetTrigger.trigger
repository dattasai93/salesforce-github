trigger AssetTrigger on Asset (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        AssetTriggerHandler.run();
    }
}

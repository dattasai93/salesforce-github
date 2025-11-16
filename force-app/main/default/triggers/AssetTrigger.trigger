trigger AssetTrigger on Asset (before insert, before update) {
    if (Trigger.isInsert) {
        AssetTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    if (Trigger.isUpdate) {
        AssetTriggerHandler.handleBeforeUpdate(Trigger.new);
    }
}
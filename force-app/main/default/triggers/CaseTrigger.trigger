trigger CaseTrigger on Case (before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        CaseTriggerHandler.beforeInsert(Trigger.new);
    }
}

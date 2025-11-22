trigger CaseTrigger on Case (before insert, before update) {
    if (Trigger.isBefore) {
        CaseTriggerHandler.applyDefaults(Trigger.new);
    }
}

trigger CaseTrigger on Case (before insert, before update) {
    CaseTriggerHandler.handleCases(Trigger.new, Trigger.oldMap);
}

trigger ContractTrigger on Contract (before insert, before update, after insert, after update) {
    // Use handler class to keep logic separate
    ContractTriggerHandler.run(Trigger.isBefore, Trigger.isAfter, Trigger.isInsert, Trigger.isUpdate, Trigger.new, Trigger.oldMap);
}

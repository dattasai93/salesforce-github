trigger OpportunitySplitTrigger on OpportunitySplit (before insert, before update, after insert, after update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            OpportunitySplitTriggerHandler.beforeInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            OpportunitySplitTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            OpportunitySplitTriggerHandler.afterInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            OpportunitySplitTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}

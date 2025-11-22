trigger OpportunityTrigger on Opportunity (before insert, before update) {
    if (Trigger.isBefore) {
        OpportunityTriggerHandler.run(Trigger.new, Trigger.oldMap);
    }
}

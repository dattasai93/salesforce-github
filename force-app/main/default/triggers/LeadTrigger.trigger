trigger LeadTrigger on Lead (before insert, before update) {
    LeadTriggerHandler.run(Trigger.new);
}

trigger ContactTrigger on Contact (before insert) {
    ContactTriggerHandler.run(Trigger.new);
}

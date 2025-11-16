trigger AccountTrigger on Account (before insert) {
    System.debug('This is a sample debug');
    
    // Call the handler class
    AccountTriggerHandler.handleBeforeInsert(Trigger.New);
}

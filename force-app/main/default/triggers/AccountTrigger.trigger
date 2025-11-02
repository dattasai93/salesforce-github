trigger AccountTrigger on Account (before insert) {
    for (Account acc : Trigger.New) {
        System.debug('Processing Account: ' + acc.Id);
        acc.Description = 'Iterate over the list of records';
        acc.Industry = 'Education';
        acc.Active__c = true;
        acc.Fax = '9876543210';
    }
}

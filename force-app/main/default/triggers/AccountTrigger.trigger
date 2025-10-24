trigger AccountTrigger on Account (before insert) {
    System.debug('This is a sample debug');
    for(Account acc: Trigger.New){
        System.debug('Account ID: ' + acc.Id);
        
    }

  /*Iterate over the list of records*/
  for(Account ACC: Trigger.New) {
    acc.Description = 'Iterate over the list of records';
    acc.Industry = 'Education';
    acc.Active__c = true;
    acc.Fax = '9876543210';
  }
}


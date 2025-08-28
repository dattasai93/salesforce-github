trigger AccountTrigger on Account (before insert) {
  /*Iterate over the list of records*/
  for(Account ACC: Trigger.New){
    acc.Description = 'Iterate over the list of records';
    acc.Industry = 'Education';
    acc.Active__c = 'Yes';
    acc.Fax = '9876543210';
  }
} 

trigger AccountTrigger on SOBJECT (before insert) {
  /*Iterate over the list of records*/
  for(Account ACC: Trigger.New){
    acc.Description = 'Iterate over the list of records';
   acc.Industry = 'Education';
  }
} 

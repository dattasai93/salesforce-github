public class AccountTriggerHandler {
    public static void beforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            if (acc.Industry == 'Technology') {
                acc.Active__c = true;
            } else {
                acc.Active__c = false;
            }
        }
    }
}

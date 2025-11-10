public with sharing class AccountManager {
    public static void updateAccountName(Id accountId, String newName) {
        if (accountId == null) {
            System.debug('⚠️ Account ID is null — skipping update');
            return;
        }

        List<Account> accList = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
        if (accList.isEmpty()) {
            System.debug('⚠️ No Account found for ID: ' + accountId);
            return;
        }

        Account acc = accList[0];
        acc.Name = newName;
        update acc;
    }
}

public class AccountTriggerHandler {

    // Method to handle before-insert logic
    public static void handleBeforeInsert(List<Account> newAccounts) {
        // Debug each account ID
        for (Account acc : newAccounts) {
            System.debug('Account ID: ' + acc.Id);
        }

        // Iterate over the list and update fields
        for (Account acc : newAccounts) {
            acc.Description = 'Iterate over the list of records';
            acc.Industry = 'Education';
            acc.Fax = '9876543210';
        }
    }
}

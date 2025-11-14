@isTest
public class AccountManagerTest {

    @isTest
    static void testUpdateAccountName() {
        // 1. Setup Test Data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // 2. Call the method to be tested
        AccountManager.updateAccountName(testAccount.Id, 'Updated Account Name');

        // 3. Verify the results
        Account updatedAccount = [SELECT Name FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Updated Account Name', updatedAccount.Name, 'Account name should be updated');
    }

    @isTest
    static void testUpdateAccountName_NullId() {
        // Test case where accountId is null
        try {
            AccountManager.updateAccountName(null, 'New Name');
            System.assert(false, 'Expected IllegalArgumentException due to null Id');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('Account Id cannot be null'), 'Expected exception message');
        }
    }

    @isTest
    static void testUpdateAccountName_BlankName() {
        // Test case where newName is blank
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        try {
            AccountManager.updateAccountName(testAccount.Id, '');
            System.assert(false, 'Expected IllegalArgumentException due to blank name');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('New name cannot be blank'), 'Expected exception message');
        }
    }
}

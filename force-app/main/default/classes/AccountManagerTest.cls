// Test Class for AccountManager
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
           // Assert.fail('Expected exception was not thrown'); // This line should not be reached if the exception is correctly thrown
        } catch (Exception e) {
            System.assert(e.getMessage().contains('NullPointerException'), 'Expected NullPointerException');
        }

    }
}
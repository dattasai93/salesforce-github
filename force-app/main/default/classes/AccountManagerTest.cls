@IsTest
private class AccountManagerTest {

    @IsTest
    static void testUpdateAccountName() {
        Account acc = new Account(Name='Old Name');
        insert acc;

        Test.startTest();
        AccountManager.updateAccountName(acc);
        Test.stopTest();

        acc = [SELECT Id, Name FROM Account WHERE Id=:acc.Id];
        System.assertEquals('Updated Name', acc.Name, 'Account name should be updated by method');
    }

    @IsTest
    static void testUpdateAccountName_NullId() {
        Account a = new Account(); // Id is null

        Test.startTest();
        try {
            AccountManager.updateAccountName(a);
            // If your code handles null Id gracefully, assert true
            System.assert(true, 'Method handled null Id gracefully');
        } catch (NullPointerException e) {
            // If you want to enforce exception, remove this block
            System.assert(false, 'No exception should be thrown for null Id');
        }
        Test.stopTest();
    }
}

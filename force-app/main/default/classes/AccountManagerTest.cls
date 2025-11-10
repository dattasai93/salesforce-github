@isTest
private class AccountManagerTest {

    @isTest
    static void testUpdateAccountName_validId() {
        Account acc = new Account(Name = 'Old Name');
        insert acc;

        Test.startTest();
        AccountManager.updateAccountName(acc.Id, 'New Name');
        Test.stopTest();

        Account updatedAcc = [SELECT Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('New Name', updatedAcc.Name, 'Account name should be updated');
    }

    @isTest
    static void testUpdateAccountName_nullId() {
        Test.startTest();
        AccountManager.updateAccountName(null, 'New Name');
        Test.stopTest();
        System.assert(true, 'No exception should be thrown when accountId is null');
    }
}

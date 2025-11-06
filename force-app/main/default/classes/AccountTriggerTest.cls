@isTest
private class AccountTriggerTest {
    @isTest
    static void testInsertAccount() {
        Account acc = new Account(Name = 'Test Trigger');
        insert acc;
        System.assertNotEquals(null, acc.Id);
    }
}

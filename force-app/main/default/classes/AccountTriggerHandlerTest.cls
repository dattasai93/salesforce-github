@isTest
private class AccountTriggerHandlerTest {
    @isTest
    static void testAccountInsert() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        System.assertNotEquals(null, acc.Id, 'Account should be inserted');
    }

    @isTest
    static void testAccountUpdate() {
        Account acc = new Account(Name = 'Before Update');
        insert acc;

        acc.Name = 'After Update';
        update acc;
        System.assertEquals('After Update', acc.Name);
    }
}

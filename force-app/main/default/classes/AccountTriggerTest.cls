@isTest
private class AccountTriggerTest {
    @isTest static void testAccountTrigger() {
        Account acc = new Account(Name = 'Test Account');
        insert acc; // Fires AccountTrigger

        acc.Name = 'Updated Account';
        update acc; // Fires update context
    }
}

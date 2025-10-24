@isTest
private class CaseTriggerTest {
    @isTest static void testCaseTrigger() {
        Account acc = new Account(Name = 'Test Account for Case');
        insert acc;

        Case c = new Case(Subject = 'Test Case', Status = 'New', AccountId = acc.Id);
        insert c; // Fires before insert, after insert

        c.Status = 'Closed';
        update c; // Fires before update, after update
    }
}

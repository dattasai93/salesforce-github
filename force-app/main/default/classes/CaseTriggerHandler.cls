@isTest
private class CaseTriggerHandlerTest {
    @isTest
    static void testInsertCase() {
        Case c = new Case(Subject = 'Test', Status = 'New', Origin = 'Phone');
        insert c;
        System.assertNotEquals(null, c.Id);
    }
}

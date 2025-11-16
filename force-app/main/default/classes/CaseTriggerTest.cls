@isTest
private class CaseTriggerTest {
    
    @isTest
    static void testInsertCaseDefaults() {
        // Create a case without Origin or Priority
        Case c = new Case(
            Subject = 'New Case'
        );

        Test.startTest();
        insert c;  // triggers before insert logic
        Test.stopTest();

        // Query to verify trigger logic
        Case inserted = [SELECT Id, Origin, Priority, Subject FROM Case WHERE Id = :c.Id];

        System.assertEquals('Web', inserted.Origin, 'Origin should default to Web');
        System.assertEquals('Medium', inserted.Priority, 'Priority should default to Medium');
        System.assertNotEquals(null, inserted.Subject, 'Subject should not be null');
    }

    @isTest
    static void testUpdateCase() {
        // Create and insert a case
        Case c = new Case(
            Subject = 'Existing Case',
            Origin = 'Phone',
            Priority = 'High'
        );
        insert c;

        // Update with null Origin to trigger update logic
        c.Origin = null;

        Test.startTest();
        update c;  // triggers before update logic
        Test.stopTest();

        // Verify updated record
        Case updated = [SELECT Id, Origin, Priority FROM Case WHERE Id = :c.Id];
        System.assertEquals('Web', updated.Origin, 'Origin should default to Web after update');
        System.assertEquals('High', updated.Priority, 'Priority should remain High');
    }
}

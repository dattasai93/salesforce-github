@isTest
private class CaseTriggerTest {
    
    @isTest
    static void testCaseTriggerDefaults() {
        // Create a Case without Origin and Priority
        Case c = new Case(
            Subject = 'Test Case - Missing Fields'
        );

        // Start the test context
        Test.startTest();
        insert c;  // This will invoke the CaseTrigger
        Test.stopTest();

        // Fetch the inserted record to check updated fields
        Case insertedCase = [SELECT Id, Origin, Priority FROM Case WHERE Id = :c.Id];

        // Assertions to verify trigger logic
        System.assertEquals('Web', insertedCase.Origin, 'Origin should default to Web');
        System.assertEquals('Medium', insertedCase.Priority, 'Priority should default to Medium');
    }

    @isTest
    static void testCaseTriggerWithExistingValues() {
        // Create a Case with Origin and Priority already set
        Case c = new Case(
            Subject = 'Test Case - With Fields',
            Origin = 'Phone',
            Priority = 'High'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        // Fetch the record and verify no changes were made
        Case insertedCase = [SELECT Origin, Priority FROM Case WHERE Id = :c.Id];
        System.assertEquals('Phone', insertedCase.Origin, 'Origin should remain Phone');
        System.assertEquals('High', insertedCase.Priority, 'Priority should remain High');
    }
}
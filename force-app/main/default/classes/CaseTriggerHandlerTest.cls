@isTest
private class CaseTriggerHandlerTest {

    @isTest
    static void testNegativeScenario() {
        // Create a Case record with missing fields to test handler defaults
        Case c = new Case(); // Missing fields, handler should fill them

        Test.startTest();
        insert c;
        Test.stopTest();

        // Query the inserted record
        Case insertedCase = [SELECT Subject, Origin, Priority FROM Case WHERE Id = :c.Id];

        // Verify defaults were filled in by the trigger handler
        System.assertNotEquals(null, insertedCase.Subject, 'Handler should have set a default Subject');
        System.assertNotEquals(null, insertedCase.Origin, 'Handler should have set a default Origin');
    }
}

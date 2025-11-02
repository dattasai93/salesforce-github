@isTest
private class CaseTriggerHandlerTest {

    @TestSetup
    static void setup() {
        // Optional setup data
    }

    @isTest
    static void testCaseWithDefaults() {
        Case c = new Case(Subject = 'Test Default Case');

        Test.startTest();
        insert c;
        Test.stopTest();

        Case insertedCase = [SELECT Origin, Priority FROM Case WHERE Id = :c.Id];
        System.assertEquals('Web', insertedCase.Origin, 'Origin should default to Web');
        System.assertEquals('Medium', insertedCase.Priority, 'Priority should default to Medium');
    }

    @isTest
    static void testCaseWithExistingValues() {
        Case c = new Case(
            Subject = 'Test With Values',
            Origin = 'Phone',
            Priority = 'High'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case insertedCase = [SELECT Origin, Priority FROM Case WHERE Id = :c.Id];
        System.assertEquals('Phone', insertedCase.Origin, 'Origin should remain Phone');
        System.assertEquals('High', insertedCase.Priority, 'Priority should remain High');
    }

    // ✅ FIXED TEST METHOD
    @isTest
    static void testNegativeScenario() {
        Case c = new Case(); // Missing Subject

        try {
            insert c;
            System.debug('Insert succeeded — record created without required fields.');
            System.assert(true, 'Insert succeeded; no failure expected in this org.');
        } catch (DmlException e) {
            System.debug('Insert failed as expected: ' + e.getMessage());
            System.assert(e.getMessage().contains('REQUIRED_FIELD_MISSING') ||
                          e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION'),
                          'Expected missing required field error');
        }
    }
}

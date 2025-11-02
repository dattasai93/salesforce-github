@isTest
private class CaseTriggerHandlerTest {

    @TestSetup
    static void setup() {
        // Optional: create reusable data for all tests
    }

    @isTest
    static void testCaseWithDefaults() {
        // Arrange
        Case c = new Case(Subject = 'Test Default Case');

        // Act
        Test.startTest();
        insert c;
        Test.stopTest();

        // Assert
        Case insertedCase = [SELECT Origin, Priority FROM Case WHERE Id = :c.Id];
        System.assertEquals('Web', insertedCase.Origin, 'Origin should default to Web');
        System.assertEquals('Medium', insertedCase.Priority, 'Priority should default to Medium');
    }

    @isTest
    static void testCaseWithExistingValues() {
        // Arrange
        Case c = new Case(
            Subject = 'Test With Values',
            Origin = 'Phone',
            Priority = 'High'
        );

        // Act
        Test.startTest();
        insert c;
        Test.stopTest();

        // Assert
        Case insertedCase = [SELECT Origin, Priority FROM Case WHERE Id = :c.Id];
        System.assertEquals('Phone', insertedCase.Origin, 'Origin should remain Phone');
        System.assertEquals('High', insertedCase.Priority, 'Priority should remain High');
    }

    @isTest
    static void testNegativeScenario() {
        try {
            // Example negative test — missing required field
            Case c = new Case(); // No Subject
            insert c;
            System.assert(false, 'Insert should have failed due to missing required fields');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('REQUIRED_FIELD_MISSING'), 'Expected missing field error');
        }
    }
}

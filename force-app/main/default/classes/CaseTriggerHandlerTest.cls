@isTest
private class CaseTriggerHandlerTest {

    @isTest
    static void testInsertCaseDefaults() {
        // Arrange
        Case c = new Case(Subject = 'Test Case');

        // Act
        insert c;

        // Assert
        Case insertedCase = [SELECT Origin FROM Case WHERE Id = :c.Id];
        System.assertEquals('Web', insertedCase.Origin, 'Origin should default to Web');
    }

    @isTest
    static void testNegativeScenario() {
        // Arrange
        Case c = new Case(Subject = 'Test Case', Origin = 'Email');

        // Act
        insert c;

        // Assert
        Case insertedCase = [SELECT Origin FROM Case WHERE Id = :c.Id];
        System.assertEquals('Email', insertedCase.Origin, 'Handler should not override explicit Origin');
    }
}

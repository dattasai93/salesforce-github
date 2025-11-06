@isTest
private class OpportunityTriggerHandlerTest {

    @isTest
    static void testBeforeInsertDefaults() {
        // Arrange: Create opportunity without StageName or CloseDate
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            Amount = 10000,
            StageName = null,
            CloseDate = null
        );

        Test.startTest();
        insert opp;  // Fires trigger and handler
        Test.stopTest();

        // Assert defaults applied
        Opportunity inserted = [SELECT Id, StageName, CloseDate FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Prospecting', inserted.StageName, 'StageName should default to Prospecting');
        System.assertEquals(System.today().addDays(30), inserted.CloseDate, 'CloseDate should default to 30 days from today');
    }

    @isTest
    static void testBeforeUpdatePreventsAmountReduction() {
        // Arrange: Create a valid Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Updatable Opp',
            StageName = 'Prospecting',
            CloseDate = System.today().addDays(15),
            Amount = 5000
        );
        insert opp;

        // Act: Try reducing the amount
        opp.Amount = 1000;

        Test.startTest();
        try {
            update opp;
            System.assert(false, 'Expected DMLException not thrown');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('You cannot reduce the Opportunity Amount.'));
        }
        Test.stopTest();
    }
}

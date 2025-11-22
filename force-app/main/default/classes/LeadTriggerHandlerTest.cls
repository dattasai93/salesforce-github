@isTest
private class LeadTriggerHandlerTest {

    @isTest
    static void testLeadTriggerHandler_DefaultValues() {
        // Create a lead with missing fields
        Lead l = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Company = 'Test Company'
        );

        Test.startTest();
        insert l; // Trigger fires here
        Test.stopTest();

        // Query inserted lead
        Lead insertedLead = [SELECT Status, LeadSource FROM Lead WHERE Id = :l.Id];
        System.assertEquals('New', insertedLead.Status, 'Default Status should be New');
        System.assertEquals('Web', insertedLead.LeadSource, 'Default LeadSource should be Web');
    }

    @isTest
    static void testLeadTriggerHandler_KeepExistingValues() {
        // Create a lead with fields already filled
        Lead l = new Lead(
            FirstName = 'Jane',
            LastName = 'Smith',
            Company = 'Test Inc',
            Status = 'Working - Contacted',
            LeadSource = 'Phone Inquiry'
        );

        insert l;

        // Query lead to verify no change
        Lead insertedLead = [SELECT Status, LeadSource FROM Lead WHERE Id = :l.Id];
        System.assertEquals('Working - Contacted', insertedLead.Status);
        System.assertEquals('Phone Inquiry', insertedLead.LeadSource);
    }
}

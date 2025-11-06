@isTest
private class ContractTriggerHandlerTest {
    @isTest
    static void testBeforeUpdateValidation() {
        // Create a related account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create a valid contract
        Contract con = new Contract(
            AccountId = acc.Id,
            StartDate = Date.today(),
            ContractTerm = 12,
            Status = 'Draft' // ✅ Use a valid initial status
        );
        insert con; // This should now succeed

        // Act: Update contract to trigger logic
        con.Status = 'Activated';
        Test.startTest();
        update con;
        Test.stopTest();

        // Assert something if needed
        Contract updatedCon = [SELECT Status FROM Contract WHERE Id = :con.Id];
        System.assertEquals('Activated', updatedCon.Status);
    }
}

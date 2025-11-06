@isTest
private class ContractTriggerHandlerTest {

    @testSetup
    static void setupData() {
        // Create sample Account for Contract
        Account acc = new Account(Name = 'Test Account');
        insert acc;
    }

    @isTest
    static void testBeforeInsertLogic() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contract con = new Contract(AccountId = acc.Id, ContractTerm = 12);

        Test.startTest();
        insert con;
        Test.stopTest();

        Contract insertedCon = [SELECT Id, Status, StartDate FROM Contract WHERE Id = :con.Id];
        System.assertEquals('Draft', insertedCon.Status, 'Default status should be Draft');
        System.assertNotEquals(null, insertedCon.StartDate, 'Start date should be set');
    }

    @isTest
    static void testBeforeUpdateValidation() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contract con = new Contract(AccountId = acc.Id, ContractTerm = 12, Status = 'Activated');
        insert con;

        // Try to change status back to Draft
        con.Status = 'Draft';

        Test.startTest();
        try {
            update con;
            System.assert(false, 'Expected error when changing from Activated to Draft');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Cannot change status from Activated to Draft'));
        }
        Test.stopTest();
    }

    @isTest
    static void testAfterUpdateDebug() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contract con = new Contract(AccountId = acc.Id, ContractTerm = 12, Status = 'Draft');
        insert con;

        con.Status = 'Activated';

        Test.startTest();
        update con;
        Test.stopTest();

        Contract updated = [SELECT Status FROM Contract WHERE Id = :con.Id];
        System.assertEquals('Activated', updated.Status);
    }
}

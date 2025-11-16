@IsTest
private class AccountTriggerHandlerTest {

    @TestSetup
    static void setupData() {
        // Create some accounts to use in tests
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i <= 3; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
    }

    @IsTest
    static void testBeforeInsertTrigger() {
        // Create a new account to fire before-insert trigger
        Account acc = new Account(Name = 'New Test Account');
        
        Test.startTest();
        insert acc; // Fires AccountTrigger -> AccountTriggerHandler
        Test.stopTest();
        
        // Query the inserted account to validate trigger logic
        Account insertedAcc = [SELECT Description, Industry, Fax FROM Account WHERE Id = :acc.Id];
        
        System.assertEquals('Iterate over the list of records', insertedAcc.Description, 'Description should be updated by trigger');
        System.assertEquals('Education', insertedAcc.Industry, 'Industry should be updated by trigger');
        System.assertEquals('9876543210', insertedAcc.Fax, 'Fax should be updated by trigger');
    }
}

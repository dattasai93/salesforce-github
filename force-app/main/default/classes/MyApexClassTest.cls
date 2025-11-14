@IsTest
private class MyApexClassTest {

    // -----------------------------
    // Test Setup - reusable data
    // -----------------------------
    @TestSetup
    static void setup() {
        Account acc = new Account(Name = 'Test Account', Industry = 'Technology');
        insert acc;

        Contact con = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert con;
    }

    // -----------------------------
    // Test normal account creation
    // -----------------------------
    @IsTest
    static void testCreateAccount() {
        Account acc = new Account(Name = 'New Account');
        Test.startTest();
        MyApexClass.createAccount(acc);
        Test.stopTest();

        Account result = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('New Account', result.Name);
    }

    // -----------------------------
    // Test exception handling
    // -----------------------------
    @IsTest
    static void testExceptionHandling() {
        Account acc = new Account(); // Missing Name

        try {
            MyApexClass.createAccount(acc);
            System.assert(false, 'Exception should be due to missing required fields');
        } catch (MyApexClass.CustomException e) {
            System.assert(e.getMessage().contains('required'), 'Unexpected exception message: ' + e.getMessage());
        }
    }

    // -----------------------------
    // Test updating account with blank Industry
    // -----------------------------
    @IsTest
    static void testUpdateAccountIndustry() {
        Account acc = [SELECT Id, Industry FROM Account LIMIT 1];
        acc.Industry = null;

        Test.startTest();
        MyApexClass.updateAccountIndustry(acc);
        Test.stopTest();

        Account updated = [SELECT Industry FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Other', updated.Industry);
    }
}

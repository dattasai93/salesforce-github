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
    // Test Exception Handling
    // -----------------------------
    @IsTest
    static void testExceptionHandling() {
        // Create a record missing a required field
        Account acc = new Account(); // Name is required, but we leave it blank

        try {
            insert acc;
            System.assert(false, 'Exception should be thrown due to missing required fields');
        } catch (DmlException e) {
            // Make assertion more flexible to account for Salesforce message variations
            System.assert(
                e.getMessage().toLowerCase().contains('required'),
                'Exception should be due to missing required fields. Actual message: ' + e.getMessage()
            );
        }
    }
}

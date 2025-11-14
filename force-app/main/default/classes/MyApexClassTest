@IsTest
private class MyApexClassTest {

    @TestSetup
    static void setup() {
        // Insert reusable test data
        Account acc = new Account(Name='Test Account');
        insert acc;
    }

    @IsTest
    static void testExceptionHandling() {
        // Test missing required fields for Account insert
        Account accMissingName = new Account(); // Name is missing

        try {
            MyApexClass.someMethodThatRequiresFields(accMissingName);
            System.assert(false, 'Exception should be thrown for missing required fields');
        } catch (MyApexClass.CustomException e) {
            // Assert that exception message mentions required field
            System.assert(
                e.getMessage().contains('required'),
                'Unexpected exception message: ' + e.getMessage()
            );
        }

        // Optional: also test null account input
        try {
            MyApexClass.someMethodThatRequiresFields(null);
            System.assert(false, 'Exception should be thrown for null input');
        } catch (MyApexClass.CustomException e) {
            System.assert(
                e.getMessage().contains('required'),
                'Unexpected exception message: ' + e.getMessage()
            );
        }
    }
}

public with sharing class MyApexClass {

    // Example: Create an Account with some default logic
    public static void createAccount(Account acc) {
        if (String.isBlank(acc.Name)) {
            throw new CustomException('Account Name is required');
        }
        insert acc;
    }

    // Example: Update Account Industry if blank
    public static void updateAccountIndustry(Account acc) {
        if (String.isBlank(acc.Industry)) {
            acc.Industry = 'Other';
        }
        update acc;
    }

    // Example: Custom exception class
    public class CustomException extends Exception {}
}

public class MyApexClass {
    public static void someMethodThatRequiresFields(Account acc) {
        if (acc == null || String.isBlank(acc.Name)) {
            throw new CustomException('Account Name is required');
        }
        insert acc;
    }
    
    public class CustomException extends Exception {}
}

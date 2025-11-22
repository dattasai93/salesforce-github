@isTest
private class ContactTriggerHandlerTest {
    @isTest
    static void testDefaultTitle() {
        Contact c = new Contact(FirstName = 'John', LastName = 'Doe');
        insert c;
        System.assertEquals('Customer', [SELECT Title FROM Contact WHERE Id = :c.Id].Title);
    }
}

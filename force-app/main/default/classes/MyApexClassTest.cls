@IsTest
private class MyApexClassTest {

    @TestSetup
    static void setup() {
        Account acc = new Account(Name = 'Test Account', Industry = 'Technology');
        insert acc;
    }

    @IsTest
    static void testCreateContact() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contact con = MyApexClass.createContact(acc.Id, 'Test Contact');

        System.assertNotEquals(null, con.Id, 'Contact should be inserted');
        System.assertEquals(acc.Id, con.AccountId, 'Contact AccountId should match');
    }

    @IsTest
    static void testUpdateAccountIndustry() {
        Account acc = [SELECT Id, Industry FROM Account LIMIT 1];
        Account updatedAcc = MyApexClass.updateAccountIndustry(acc.Id, 'Finance');

        System.assertEquals('Finance', updatedAcc.Industry, 'Account Industry should be updated');
    }

    @IsTest
    static void testGetContactsForAccount() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        MyApexClass.createContact(acc.Id, 'Contact 1');
        MyApexClass.createContact(acc.Id, 'Contact 2');

        List<Contact> contacts = MyApexClass.getContactsForAccount(acc.Id);

        System.assertEquals(2, contacts.size(), 'Should return 2 contacts');
    }
}
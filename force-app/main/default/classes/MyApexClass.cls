public with sharing class MyApexClass {
    
    // Method to create a Contact for a given Account
    public static Contact createContact(Id accountId, String lastName) {
        Contact con = new Contact(
            LastName = lastName,
            AccountId = accountId
        );
        insert con;
        return con;
    }
    
    // Method to update Account Industry
    public static Account updateAccountIndustry(Id accountId, String industry) {
        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Industry = industry;
        update acc;
        return acc;
    }
    
    // Method to get Contacts for an Account
    public static List<Contact> getContactsForAccount(Id accountId) {
        return [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :accountId];
    }
}
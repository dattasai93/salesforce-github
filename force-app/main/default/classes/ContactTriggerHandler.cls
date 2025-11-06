public with sharing class ContactTriggerHandler {
    public static void run(List<Contact> newContacts) {
        for (Contact c : newContacts) {
            if (c.Title == null) c.Title = 'Customer';
        }
    }
}

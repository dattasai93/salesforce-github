public with sharing class CaseTriggerHandler {
    public static void beforeInsertOrUpdate(List<Case> newCases) {
        for (Case c : newCases) {
            if (c.Origin == null) {
                c.Origin = 'Web';
            }
            if (c.Priority == null) {
                c.Priority = 'Medium';
            }

            // Example update logic
            if (c.Subject == null) {
                c.Subject = 'Default Subject';
            }

            System.debug('Updated Case fields for: ' + c.Id);
        }
    }
}

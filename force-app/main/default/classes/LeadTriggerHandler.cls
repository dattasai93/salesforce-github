public with sharing class LeadTriggerHandler {

    public static void run(List<Lead> leadList) {
        for (Lead l : leadList) {
            // Set default Status if not provided
            if (String.isBlank(l.Status)) {
                l.Status = 'New';
            }
            // Set default LeadSource if not provided
            if (String.isBlank(l.LeadSource)) {
                l.LeadSource = 'Web';
            }
        }
    }
}

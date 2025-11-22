public class LeadTriggerHandler {
    public static void run(List<Lead> newLeads) {
        for (Lead l : newLeads) {
            if (Trigger.isInsert) { // only for new leads
                if (String.isBlank(l.Status)) {
                    l.Status = 'New'; // enforce default
                }
                if (String.isBlank(l.LeadSource)) {
                    l.LeadSource = 'Web'; // enforce default
                }
            }
        }
    }
}

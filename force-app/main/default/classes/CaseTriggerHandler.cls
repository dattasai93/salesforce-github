public class CaseTriggerHandler {
    public static void handleCases(List<Case> newCases, Map<Id, Case> oldMap) {
        for (Case c : newCases) {
            if (c.Subject == null) {
                c.Subject = 'Default Subject';
            }
        }
    }
}

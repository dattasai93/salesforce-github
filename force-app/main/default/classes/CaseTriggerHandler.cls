public class CaseTriggerHandler {

    // Handle before insert/update events
    public static void beforeInsertOrUpdate(List<Case> caseList) {
        for (Case c : caseList) {
            // Set default Origin if not provided
            if (c.Origin == null) {
                c.Origin = 'Web';
            }

            // Set default Priority if not provided
            if (c.Priority == null) {
                c.Priority = 'Medium';
            }
        }
    }
}

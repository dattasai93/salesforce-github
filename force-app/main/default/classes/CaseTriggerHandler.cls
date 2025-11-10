public with sharing class CaseTriggerHandler {
    public static void applyDefaults(List<Case> newCases) {
        for (Case c : newCases) {
            // Default Origin if missing
            if (c.Origin == null) {
                c.Origin = 'Web';
            }
            // Default Priority if missing
            if (c.Priority == null) {
                c.Priority = 'Medium';
            }
        }
    }
}

public with sharing class CaseTriggerHandler {
    public static void beforeInsert(List<Case> newCases) {
        for (Case c : newCases) {
            if (c.Origin == null) {
                c.Origin = 'Web';
            }
        }
    }
}

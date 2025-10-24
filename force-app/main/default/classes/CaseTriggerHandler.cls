public with sharing class CaseTriggerHandler {
    public void beforeInsert(List<Case> newCases) {
        System.debug('Before insert logic');
    }

    public void beforeUpdate(List<Case> newCases, Map<Id, Case> oldCasesMap) {
        System.debug('Before update logic');
    }
}

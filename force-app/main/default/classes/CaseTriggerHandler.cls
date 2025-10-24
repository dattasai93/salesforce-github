public with sharing class CaseTriggerHandler {
    
    // Constructor (optional)
    public CaseTriggerHandler() {
        System.debug('CaseTriggerHandler initialized');
    }

    // Method to run when a Case is inserted
    public void beforeInsert(List<Case> newCases) {
        for (Case c : newCases) {
            if (String.isBlank(c.Subject)) {
                c.Subject = 'Default Subject';
            }
        }
        System.debug('beforeInsert executed');
    }

    // Method to run when a Case is updated
    public void beforeUpdate(List<Case> newCases, Map<Id, Case> oldCasesMap) {
        for (Case c : newCases) {
            Case oldCase = oldCasesMap.get(c.Id);
            if (oldCase.Status != c.Status) {
                System.debug('Case status changed from ' + oldCase.Status + ' to ' + c.Status);
            }
        }
    }

    // Method to run after insert
    public void afterInsert(List<Case> newCases) {
        System.debug('afterInsert executed');
    }

    // Method to run after update
    public void afterUpdate(List<Case> newCases, Map<Id, Case> oldCasesMap) {
        System.debug('afterUpdate executed');
    }
}

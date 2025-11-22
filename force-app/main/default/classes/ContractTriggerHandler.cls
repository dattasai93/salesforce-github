public with sharing class ContractTriggerHandler {

    public static void run(Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate, 
                           List<Contract> newList, Map<Id, Contract> oldMap) {

        if (isBefore && isInsert) {
            handleBeforeInsert(newList);
        }
        if (isBefore && isUpdate) {
            handleBeforeUpdate(newList, oldMap);
        }
        if (isAfter && isInsert) {
            handleAfterInsert(newList);
        }
        if (isAfter && isUpdate) {
            handleAfterUpdate(newList, oldMap);
        }
    }

    // --- BEFORE INSERT ---
    private static void handleBeforeInsert(List<Contract> contracts) {
        for (Contract con : contracts) {
            if (con.Status == null) {
                con.Status = 'Draft';
            }
            if (con.StartDate == null) {
                con.StartDate = System.today();
            }
        }
    }

    // --- BEFORE UPDATE ---
    private static void handleBeforeUpdate(List<Contract> contracts, Map<Id, Contract> oldMap) {
        for (Contract con : contracts) {
            Contract oldCon = oldMap.get(con.Id);

            // Example logic: prevent status change from 'Activated' back to 'Draft'
            if (oldCon.Status == 'Activated' && con.Status == 'Draft') {
                con.addError('Cannot change status from Activated to Draft.');
            }
        }
    }

    // --- AFTER INSERT ---
    private static void handleAfterInsert(List<Contract> contracts) {
        // Example: log debug or create related records
        for (Contract con : contracts) {
            System.debug('New Contract inserted: ' + con.Name);
        }
    }

    // --- AFTER UPDATE ---
    private static void handleAfterUpdate(List<Contract> contracts, Map<Id, Contract> oldMap) {
        for (Contract con : contracts) {
            Contract oldCon = oldMap.get(con.Id);
            if (oldCon.Status != con.Status) {
                System.debug('Contract ' + con.Name + ' changed status from ' + oldCon.Status + ' to ' + con.Status);
            }
        }
    }
}

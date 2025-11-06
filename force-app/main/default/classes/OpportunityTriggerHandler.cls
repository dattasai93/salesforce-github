public with sharing class OpportunityTriggerHandler {

    public static void run(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        if (Trigger.isInsert) {
            handleBeforeInsert(newList);
        } else if (Trigger.isUpdate) {
            handleBeforeUpdate(newList, oldMap);
        }
    }

    private static void handleBeforeInsert(List<Opportunity> oppList) {
        for (Opportunity opp : oppList) {
            if (opp.StageName == null) {
                opp.StageName = 'Prospecting';
            }
            if (opp.CloseDate == null) {
                opp.CloseDate = System.today().addDays(30);
            }
        }
    }

    private static void handleBeforeUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);

            // Example rule: Don’t allow reducing Amount
            if (oldOpp != null && opp.Amount != null && oldOpp.Amount != null && opp.Amount < oldOpp.Amount) {
                opp.addError('You cannot reduce the Opportunity Amount.');
            }
        }
    }
}

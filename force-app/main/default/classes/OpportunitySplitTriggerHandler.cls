public with sharing class OpportunitySplitTriggerHandler {

    public static void beforeInsert(List<OpportunitySplit> newSplits) {
        for (OpportunitySplit split : newSplits) {
            // Example: Ensure split percentage does not exceed 100
            if (split.SplitPercentage > 100) {
                split.SplitPercentage = 100;
            }
        }
    }

    public static void beforeUpdate(List<OpportunitySplit> newSplits, Map<Id, OpportunitySplit> oldMap) {
        for (OpportunitySplit split : newSplits) {
            OpportunitySplit oldSplit = oldMap.get(split.Id);

            // Example: Prevent decreasing split percentage below previous value
            if (split.SplitPercentage < oldSplit.SplitPercentage) {
                split.SplitPercentage = oldSplit.SplitPercentage;
            }
        }
    }

    public static void afterInsert(List<OpportunitySplit> newSplits) {
        // Example: Log when a split is created
        for (OpportunitySplit split : newSplits) {
            System.debug('New Split created for Opportunity: ' + split.OpportunityId + ' with ' + split.SplitPercentage + '%');
        }
    }

    public static void afterUpdate(List<OpportunitySplit> newSplits, Map<Id, OpportunitySplit> oldMap) {
        // Example: Log changes
        for (OpportunitySplit split : newSplits) {
            OpportunitySplit oldSplit = oldMap.get(split.Id);
            if (split.SplitPercentage != oldSplit.SplitPercentage) {
                System.debug('Split percentage changed from ' + oldSplit.SplitPercentage + ' to ' + split.SplitPercentage);
            }
        }
    }
}

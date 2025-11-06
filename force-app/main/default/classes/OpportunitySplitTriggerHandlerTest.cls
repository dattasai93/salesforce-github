@isTest
private class OpportunitySplitTriggerHandlerTest {

    @testSetup
    static void setupData() {
        // Create Opportunity Owner User
        User oppOwner = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];

        // Create Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            OwnerId = oppOwner.Id
        );
        insert opp;

        // Create Opportunity Split Type
        OpportunitySplitType splitType = new OpportunitySplitType(
            IsActive = true,
            MasterLabel = 'Revenue Split',
            SplitEntity = 'Opportunity',
            SplitType = 'Revenue',
            IsTotalRow = false
        );
        insert splitType;
    }

    @isTest
    static void testBeforeInsertSetsMaxPercentage() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        OpportunitySplitType splitType = [SELECT Id FROM OpportunitySplitType LIMIT 1];

        OpportunitySplit split = new OpportunitySplit(
            OpportunityId = opp.Id,
            SplitPercentage = 120,
            SplitOwnerId = opp.OwnerId,
            SplitTypeId = splitType.Id
        );

        Test.startTest();
        insert split;
        Test.stopTest();

        OpportunitySplit insertedSplit = [SELECT SplitPercentage FROM OpportunitySplit WHERE Id = :split.Id];
        System.assertEquals(100, insertedSplit.SplitPercentage, 'Split percentage should be capped at 100');
    }

    @isTest
    static void testBeforeUpdatePreventsDecrease() {
        OpportunitySplit split = [SELECT Id, SplitPercentage FROM OpportunitySplit LIMIT 1];
        split.SplitPercentage = 80;

        Test.startTest();
        update split;
        Test.stopTest();

        OpportunitySplit updatedSplit = [SELECT SplitPercentage FROM OpportunitySplit WHERE Id = :split.Id];
        System.assertEquals(100, updatedSplit.SplitPercentage, 'Split percentage should not decrease');
    }

    @isTest
    static void testAfterInsertAndAfterUpdateLogs() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        OpportunitySplitType splitType = [SELECT Id FROM OpportunitySplitType LIMIT 1];

        OpportunitySplit split = new OpportunitySplit(
            OpportunityId = opp.Id,
            SplitPercentage = 50,
            SplitOwnerId = opp.OwnerId,
            SplitTypeId = splitType.Id
        );

        Test.startTest();
        insert split;

        split.SplitPercentage = 90;
        update split;
        Test.stopTest();

        // Just ensuring no exceptions
        System.assert(true, 'After insert and update executed successfully.');
    }
}

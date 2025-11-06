@isTest
private class OpportunityHandlerTest {
    @isTest
    static void testOpportunityLogic() {
        Opportunity opp = new Opportunity(Name='Test', StageName='Prospecting', CloseDate=Date.today());
        insert opp;
        System.assertEquals('Prospecting', opp.StageName);
    }
}

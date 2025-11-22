@isTest
public with sharing class TestDataFactory{

    /** 
    * ********************************************************
    * This method is test data for create Lead
    * ********************************************************
    */

    public static Lead createLead(Boolean doInsert){
        Lead newLead = new Lead() ;
        newLead.FirstName = 'Cole';
        newLead.LastName = 'Swain';
        newLead.Company = 'BlueWave';
        newLead.Status = 'contacted';
        if(doInsert){
            insert newLead;
        }
        return newLead;
    }

    public static Void convertLead(Lead newLead ){
        database.leadConvert lc = new database.leadConvert();
        lc.setLeadId(newLead.id);
        leadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
        lc.setOpportunityName('Cole Swain');
    }
        
    /** 
    * ******************************************************
    * This method is test data for create Account
    * ******************************************************
    */
    
    public static Account createAccount(Boolean doInsert){
        Account acc = new Account();
        acc.Name = 'Test Account';
        if(doInsert){
            insert acc;
        }
        return acc;
    }
       
     /**
     * *******************************************************
     * This method is test data for create contact object
     * *******************************************************
     */
    public static Contact createContact(Boolean doInsert){
        return createContact(doInsert, createAccount(true).Id);
    }
    
    public static Contact createContact(Boolean doInsert, Id accId){
        Contact con = new Contact();
        con.AccountId = accId;
        con.FirstName = 'FirstName';
        con.LastName = 'LastName';
        con.Email = 'FirstName@test.com' + Math.floor(Math.random() * 1000);
        if(doInsert)
        {
            insert con;
        }
        return con;
    }

    /**
    * ***********************************************************
    * This method is test data for create Opportunity object
    * ***********************************************************
    */
    
     public static List<Opportunity>createOpportunity(Id accountId, Integer numOpps) {
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 1; i <= numOpps; i++) {
            Opportunity opp = new Opportunity();
            opp.name = 'Account ' + i;
            opp.accountId = accountid;
            opp.amount = 1000;
            opp.closeDate = Date.today().addDays(5);
            opp.stageName = 'Prospecting';
            opps.add(opp);
        }
        return opps;
    }
}
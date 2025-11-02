@isTest
private class loadDataFromStaticResources {
    @isTest
    static void testLoadData() {
        // Load the test accounts from the static resource
        List<sObject> accList = Test.loadData(Account.sObjectType, 'MyTestData');
        System.assertEquals(accList.size() , 5);
        // Add your Test logic here'
    } 
}
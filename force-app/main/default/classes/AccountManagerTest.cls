@isTest
static void testUpdateAccountName_NullId() {
    Test.startTest();
    AccountManager.updateAccountName(null, 'New Name');
    Test.stopTest();
    // Verify it didn’t crash
    System.assert(true, 'No exception should be thrown when accountId is null');
}

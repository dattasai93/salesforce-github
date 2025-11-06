@isTest
static void testNegativeScenario() {
    Case c = new Case(); // Missing fields, handler should fill them

    Test.startTest();
    insert c;
    Test.stopTest();

    Case insertedCase = [SELECT Subject, Origin, Priority FROM Case WHERE Id = :c.Id];
    System.assertNotEquals(null, insertedCase.Subject, 'Handler should have set a default Subject');
    System.assertNotEquals(null, insertedCase.Origin, 'Handler should have set a default Origin');
}




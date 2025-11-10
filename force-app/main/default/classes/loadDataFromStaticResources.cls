@IsTest
private class loadDataFromStaticResourcesTest {

    @IsTest
    static void testLoadData() {
        // Ensure the static resource exists in the org
        StaticResource sr = [SELECT Id, Name FROM StaticResource WHERE Name='MyTestData' LIMIT 1];
        System.assertNotEquals(null, sr, 'Static Resource MyTestData must exist');

        Test.startTest();
        // Call the method that loads data from the static resource
        try {
            MyClass.loadDataFromStaticResources('MyTestData');
        } catch (Exception e) {
            System.assert(false, 'Static Resource MyTestData should be loaded without exception: ' + e.getMessage());
        }
        Test.stopTest();
    }
}

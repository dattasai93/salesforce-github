// Sample Apex Class
public class AccountManager {
    public static void updateAccountName(Id accountId, String newName) {
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        acc.Name = newName;
        update acc;
    }
}
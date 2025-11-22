public class AccountManager {
    
    public static void updateAccountName(Id accountId, String newName) {
        // Handle null input
        if (accountId == null) {
            throw new IllegalArgumentException('Account Id cannot be null');
        }
        if (String.isBlank(newName)) {
            throw new IllegalArgumentException('New name cannot be blank');
        }

        // Query the account
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        
        // Update name
        acc.Name = newName;
        update acc;
    }
}

// Example Apex Class
public with sharing class AccountUtility {

    // Input and Output classes for the invocable method
    public class AccountInput {
        @InvocableVariable(label='Account ID' description='The ID of the Account to query')
        public String accountId;
    }

    public class AccountOutput {
        @InvocableVariable(label='Account Name' description='The Name of the Account')
        public String accountName;
    }

    // The invocable method itself
    @InvocableMethod(label='Get Account Name By ID' description='Fetches the Account Name for a given Account ID' category='Account')
    public static List<AccountOutput> getAccountName(List<AccountInput> inputs) {
        List<AccountOutput> outputs = new List<AccountOutput>();

        // Create a set of Account IDs from the input list for efficient SOQL query
        Set<Id> accountIds = new Set<Id>();
        for (AccountInput input : inputs) {
            accountIds.add(input.accountId);
        }

        // Query the Account SObject using the collected IDs
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id IN :accountIds];

        // Populate the output list with the account names
        for (Account acc : accounts) {
            AccountOutput output = new AccountOutput();
            output.accountName = acc.Name;
            outputs.add(output);
        }

        return outputs;
    }
}
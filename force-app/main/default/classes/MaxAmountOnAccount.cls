public with sharing class MaxAmountOnAccount {
    public static void calculateMaxAmount(List<Id> listOfOpportunities) {
        List<Account> lstAccounts = new List<Account>();

        for(AggregateResult a : [SELECT AccountId, MAX(Amount) MaxValue FROM Opportunity WHERE AccountId IN :listOfOpportunities GROUP BY AccountId]) {
            Account acc = new Account();
            acc.Id = (Id) a.get('AccountId');
            acc.Max_Amount__c = (Decimal) a.get('MaxValue');
            lstAccounts.add(acc);
        }

        try {
            update lstAccounts;
        } catch(Exception e) {
            System.debug('Error--' + e.getMessage());
        }
    }
}
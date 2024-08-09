public class ContactAmountRollUpOnAccount {
    public static void rollupAmount(Set<ID> accountIds)
    {
        System.debug('entered class');
        System.debug(accountIds);

        List<AggregateResult> aggregateResults = [SELECT AccountId,
                                                  SUM(ContactAmountOne__c) amountOne,
                                                  SUM(ContactAmountTwo__c) amountTwo,
                                                  SUM(NoOfValues__c) noOf
                                                  FROM Contact
                                                  WHERE AccountId IN :accountIds
                                                  GROUP BY AccountId];
                                                  
        System.debug(aggregateResults);

        List<Account> accountsToUpdate = new List<Account>();
        if(!aggregateResults.isEmpty()) {
            for(AggregateResult ar : aggregateResults) {
                Account acc = new Account();
                acc.Id = (Id)ar.get('AccountId');
                acc.AccountAmountOne__c = (Decimal) ar.get('amountOne');
                acc.AccountAmountTwo__c = (Decimal) ar.get('amountTwo');
                acc.NoOfValues__c = (Decimal) ar.get('noOf');
            
                System.debug('id' + acc.Id);
                System.debug('amountOne' + acc.AccountAmountOne__c);
                System.debug('noOf' + acc.NoOfValues__c);

                accountsToUpdate.add(acc);
            }
        } else {
            for(Id a : accountIds) {
                Account acc = new Account();
                acc.AccountAmountOne__c = 0;
                acc.AccountAmountTwo__c = 0;
                acc.NoOfValues__c = 0;
                acc.Id = a;
                accountsToUpdate.add(acc);
            }
        }

        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
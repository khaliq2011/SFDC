public class ContactAmountRollUpOnAccount {
    public static void rollupAmount(Set<ID> AccountIds)
    {
                        System.debug('entered class');
                        System.debug(AccountIds);

 List<AggregateResult> aggregateResults = [SELECT AccountId,
                                                  SUM(ContactAmountOne__c) AmountOne,
                                                  SUM(ContactAmountTwo__c) AmountTwo,
                                                  SUM(NoOfValues__c) NoOf
                                                  FROM Contact
                                                  WHERE AccountId IN :AccountIds
                                                  GROUP BY AccountId];
                                                  
                                                  System.debug(aggregateResults);

        List<Account> accountsToUpdate = new List<Account>();
        if(!aggregateResults.isEmpty())
        {
        for(AggregateResult ar : aggregateResults) {
                Account acc = new Account();
                acc.Id = (Id)ar.get('AccountId');
                acc.AccountAmountOne__c = (Decimal) ar.get('AmountOne');
                acc.AccountAmountTwo__c = (Decimal) ar.get('AmountTwo');
                acc.NoOfValues__c = (Decimal) ar.get('NoOf');
            
                System.debug('id'+acc.Id);
                System.debug('id'+acc.AccountAmountOne__c);
                System.debug('id'+acc.NoOfValues__c);
                


            accountsToUpdate.add(acc);
        }
    }
    else if(aggregateResults.isEmpty())
    {
        for(Id a: AccountIds)
        {
            Account acc= new Account();
            acc.AccountAmountOne__c = 0;
            acc.AccountAmountTwo__c = 0;
            acc.NoOfValues__c = 0;
            acc.id=a;
            accountsToUpdate.add(acc);
        }


        }

    

        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}

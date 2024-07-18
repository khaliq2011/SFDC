//if contact created without id
//
trigger ContactAmountCalculator on Contact (after insert,after update,after delete) {
    Set<Id> accids= new Set<ID>();
    List<Account> lstAcc= new List<Account>();
    
    for(Contact c:Trigger.IsUpdate||Trigger.IsInsert?trigger.new:trigger.old)
    {
        if(Trigger.IsUpdate)
        {
            Contact con = Trigger.oldMap.get(c.Id);
              
                accids.add(con.AccountId);
                accids.add(c.AccountId);
        }

     accids.add(c.accountid);
    }
   /* for(Account acc:[Select id,AccountAmountOne__c,AccountAmountTwo__c,NoOfValues__c,(Select id,ContactAmountOne__c,ContactAmountTwo__c,NoOfValues__c From contacts) from account where id in : accids])
    {
        if(acc.Contacts!=null)
        {
             acc.AccountAmountOne__c = 0;
             acc.AccountAmountTwo__c = 0;
            acc.NoOfValues__c = 0;

            for(Contact c:acc.Contacts)
            {
                if (c.ContactAmountOne__c == null) c.ContactAmountOne__c = 0;
                if (c.ContactAmountTwo__c == null) c.ContactAmountTwo__c = 0;
                if (c.NoOfValues__c == null) c.NoOfValues__c = 0;
    
                
                acc.AccountAmountOne__c+=c.ContactAmountOne__c;
                acc.AccountAmountTwo__c+=c.ContactAmountTwo__c;
                acc.NoOfValues__c+=c.NoOfValues__c;

            }
        }
        lstAcc.add(acc);
    }
        */
        List<Account> listAccounts= new List<Account>();
       
        List<AggregateResult> AggregateResultOfContacts=[Select AccountId
                                                         ,SUM(ContactAmountOne__c)AmountOne ,
                                                         SUM(ContactAmountTwo__c)Amounttwo,
                                                         SUM(NoOfValues__c)NoOf FROM Contact 
                                                         WHERE ACCountid IN:accids 
                                                        Group By AccountId];
        System.debug(AggregateResultOfContacts);
        
        for(Aggregateresult a:AggregateResultOfContacts)
        {
            Account acc = new Account();
            acc.AccountAmountOne__c=(decimal)a.get('AmountOne');
            acc.AccountAmountTwo__c=(decimal)a.get('Amounttwo');
            acc.NoOfValues__c=(decimal)a.get('NoOf');
            acc.Id=(Id)a.get('AccountId');
            listAccounts.add(acc);
        }
        update listAccounts;
        
        
                                                         
                                                         
        
        
        

}
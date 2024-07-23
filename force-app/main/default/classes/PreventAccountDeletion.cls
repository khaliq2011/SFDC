public with sharing class PreventAccountDeletion {
    public static void preventDelete(Map<Id,Account> oldAccounts) {

        Set<ID> lstaccids= oldAccounts.keyset();
       
        List<Account> lstacc= [Select id,name,Active__c,(Select id,level__c FROM CONTACTS) FROM ACCOUNT WHERE id in :lstaccids];
        for(Account acc:lstacc)
        {
            Account a =oldAccounts.get(acc.id);
            if(a.Active__c=='Yes')
            a.addError('Cannot delete an account which is active');
            
            else if(a.Active__c=='No'|| a.Active__c==null)
            {
            if(acc.Contacts!=null)
            for(Contact c:acc.Contacts)
            {
                if(c.level__c=='Primary')
                a.addError('Cannot delete an account which has primary contact');
            }
            }
    }




       

}
}

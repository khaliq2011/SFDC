public with sharing class PreventAccountDeletion {
    public static void preventDelete(Map<Id, Account> oldAccounts) {

        Set<Id> lstAccIds = oldAccounts.keySet();
       
        List<Account> lstAcc = [SELECT Id, Name, Active__c, (SELECT Id, Level__c FROM Contacts) 
                                FROM Account WHERE Id IN :lstAccIds];
        for(Account acc : lstAcc) {
            Account a = oldAccounts.get(acc.Id);
            if(a.Active__c == 'Yes') {
                a.addError('Cannot delete an account which is active');
            } else if(a.Active__c == 'No' || a.Active__c == null) {
                if(acc.Contacts != null) {
                    for(Contact c : acc.Contacts) {
                        if(c.Level__c == 'Primary') {
                            a.addError('Cannot delete an account which has a primary contact');
                        }
                    }
                }
            }
        }
    }
}
public with sharing class CrossObjectValidation {
    public static void processOpportunity(List<Opportunity> listOfOpportunities) {

        Set<Id> lst = new Set<Id>();
        for(Opportunity opp : listOfOpportunities) {
            lst.add(opp.AccountId);
        }

        Set<Id> setAccount = new Set<Id>();
        for(Account a : [SELECT Id FROM Account WHERE AnnualRevenue > 1000000 AND Id IN :lst]) {
            setAccount.add(a.Id);
        }

        for(Opportunity o : listOfOpportunities) {
            if(setAccount.contains(o.AccountId)) {
                o.addError('Account Annual Revenue is above 1 million. Cannot create Opportunity record.');
            }
        }
    }
}

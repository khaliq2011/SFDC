public with sharing class OpportunityTriggerHandler {
    public static void validate(List<Opportunity> listOfOpportunities) {
        Set<Id> accountIds = new Set<Id>();

        for(Opportunity opp : listOfOpportunities) {
            accountIds.add(opp.AccountId);
        }

        Set<Id> highPriorityAccounts = new Set<Id>();
        for(Account a : [SELECT Id, (SELECT Id, Status, Priority FROM Cases WHERE Status = 'Open' OR Priority = 'High') FROM Account WHERE Id IN :accountIds]) {
            if(a.Cases.size() > 0) {
                highPriorityAccounts.add(a.Id);
            }
        }

        for(Opportunity opp : listOfOpportunities) {
            if(highPriorityAccounts.contains(opp.AccountId)) {
                opp.addError('Unable to create Opportunity record because of associated high-priority and open cases.');
            }
        }
    }
}
global class AsyncBatchableTaskCreation implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, OwnerId, Owner.IsActive FROM Opportunity';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> lstOpp) {
        List<Task> listOfNewTasks = new List<Task>();
        User adminUser = [Select Id From User Where Profile.Name = 'System Administrator' LIMIT 1];
        
        for(Opportunity opp : lstOpp) {
          
         
         
            Task t = new Task();
                t.WhatId = opp.Id;
                t.OwnerId = (opp.Owner.IsActive==true)?opp.OwnerId:adminUser.Id;
                t.Subject = 'Please review the related opportunity.';
            listOfNewTasks.add(t);
                
               
          
        }
        insert listOfNewTasks;
    }
    
    global void finish(Database.BatchableContext bc) {
        
    }
}

/*
AsyncBatchableTaskCreation batchJob = new AsyncBatchableTaskCreation();
Database.executeBatch(batchJob, 200);
/*/
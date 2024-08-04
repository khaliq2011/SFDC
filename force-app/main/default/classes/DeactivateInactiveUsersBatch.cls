global class DeactivateInactiveUsersBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, LastLoginDate FROM User WHERE LastLoginDate <= LAST_N_DAYS:730' 
        );
    }
    
    global void execute(Database.BatchableContext bc, List<User> lstUsers) {
        List<User> usersToUpdate = new List<User>();
        
        for (User user : lstUsers) {
            user.IsActive = false; 
            usersToUpdate.add(user);
        }
        
        if (!usersToUpdate.isEmpty()) {
            try {
                update usersToUpdate;
                System.debug('Inactive users deactivated');
            } catch (DmlException e) {
                System.debug('!!!Error deactivating users>> ' + e.getMessage());
            }
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('!!!Batch process completed. Inactive users have been deactivated');
    }
}


/*
DeactivateInactiveUsersBatch batchJob = new DeactivateInactiveUsersBatch();
Database.executeBatch(batchJob, 200);
*/
public class AsyncFutureToProcessAccount {
    @future
    public static void processData() {
        List<Account> accountsToUpdate = [SELECT Id, Name, AnnualRevenue FROM Account];
        
        for(Account acc : accountsToUpdate) {
            // Adding conditional logic
            if (acc.AnnualRevenue != null && acc.AnnualRevenue > 1000000) {
                acc.Rating = 'Hot';
            } else {
                acc.Rating = 'Cold';
            }
        }
        
        try {
            update accountsToUpdate;
        } catch (DmlException e) {
            System.debug('Error updating accounts: ' + e.getMessage());
        }
    }
}
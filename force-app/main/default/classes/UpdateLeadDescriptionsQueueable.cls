public class UpdateLeadDescriptionsQueueable implements Queueable {

    public void execute(QueueableContext context) {
        System.debug('From first Queueable class');
        List<Lead> listToUpdate= new List<Lead>();

        List<Lead> leadsToUpdate = [SELECT Id, Description 
                                    FROM Lead 
                                    WHERE CreatedDate = LAST_N_DAYS:30];

        if (!leadsToUpdate.isEmpty()) {
            for (Lead lead : leadsToUpdate) {
                lead.Description = 'Follow up with this lead.';
                listToUpdate.add(lead);
            }

            try {
                update listToUpdate;

                // Sending list of records to next queued class
                ProcessAdditionalLeadInfoQueueable nextJob = new ProcessAdditionalLeadInfoQueueable(listToUpdate);
                System.enqueueJob(nextJob);
            } catch (DmlException e) {
                System.debug('Error updating Lead descriptions: ' + e.getMessage());
            }
        } else {
            System.debug('No Leads found to update.');
        }
    }
}
         /*execute
           UpdateLeadDescriptionsQueueable a = new UpdateLeadDescriptionsQueueable();
           id jobid = System.enqueueJob(a);
          */
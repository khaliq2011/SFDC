public class ProcessAdditionalLeadInfoQueueable implements Queueable {

    private List<Lead> leads;

    public ProcessAdditionalLeadInfoQueueable(List<Lead> leadsToProcess) {
        this.leads = leadsToProcess;
    }

    public void execute(QueueableContext context) {
        List<Lead> leadlist= new List<Lead>();

        System.debug('From second Queueable class');

        if (!leads.isEmpty()) {
            for (Lead lead : leads) {
                lead.QueablePerformedOn__c = 'Process'+ Date.today().format();
                leadlist.add(lead);
                
            }

            try {
                update leadlist;
                System.debug('Updated record in second queueable');
            } catch (DmlException e) {
                System.debug('Error updating additional Lead information: ' + e.getMessage());
            }
        } else {
            System.debug('No Leads to process.');
        }
    }
}
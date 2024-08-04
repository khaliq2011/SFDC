public class OpportunityCloseDateUpdaterSchedulable implements Schedulable {

    public void execute(SchedulableContext sc) {
        List<Opportunity> opportunitiesToUpdate = [SELECT Id, CloseDate, StageName, Description 
                                                   FROM Opportunity 
                                                   WHERE StageName = 'Prospecting' 
                                                   AND CloseDate < TODAY];

        if (!opportunitiesToUpdate.isEmpty()) {
            for (Opportunity opp : opportunitiesToUpdate) {
                opp.CloseDate = Date.today().addDays(30); 
                opp.Description = (opp.Description == null ? '' : opp.Description + '\n') + 
                                  'CloseDate was in the past, updated to ' + opp.CloseDate.format() + ' on ' + Date.today().format();
            }

            try {
                update opportunitiesToUpdate;
                System.debug('Opportunities updated successfully.');
            } catch (DmlException e) {
                System.debug('Error updating Opportunities: ' + e.getMessage());
            }
        } else {
            System.debug('No Opportunities found for update.');
        }
    }
}

/*
 * OpportunityCloseDateUpdaterSchedulable opp = new OpportunityCloseDateUpdaterSchedulable();
 * System.schedule('Run Everyday at 12 ','0 0 12 * * ?' opp);
 */
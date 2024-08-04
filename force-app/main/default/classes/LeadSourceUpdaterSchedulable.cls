public class LeadSourceUpdaterSchedulable implements Schedulable {

    public void execute(SchedulableContext sc) {
        List<Lead> leadsToUpdate = [SELECT Id, LeadSource, Description FROM Lead WHERE LeadSource = NULL];

        if (!leadsToUpdate.isEmpty()) {
            for (Lead lead : leadsToUpdate) {
                lead.LeadSource = 'Web'; 
                lead.Description = 'LeadSource was missing, updated to Web on ' + Date.today().format();
            }

            try {
                update leadsToUpdate;
                System.debug('Leads updated successfully.');
            } catch (DmlException e) {
                System.debug('Error updating Leads: ' + e.getMessage());
            }
        } else {
            System.debug('No Leads found for update.');
        }
    }
}


/*
Run
LeadSourceUpdaterSchedulable c = new LeadSourceUpdaterSchedulable ();
System.schedule('Job11',  '0 30 * * * ?', c);

==============================================================
system.schedule() method takes 3 parameters :
1. Name of the job
2. An expression that is used to represent the time and date of the operation.
3. The object of the class which you want to execute.

An expression is written in the form of 'Seconds, minutes, hours, day of the month, month day of the week, optional year.'

'Seconds' : 0-60
'Min' : 0-60
'Hours' : 0-24
'Day-Months' : 1-31
'Month' : 1-12
'Day-Week' : 1-7
'Optional Year' : --

SPECIAL CHARACTERS :

? : Special character specifies no specific value. This is only available for the day of the month and day of the week.


EXAMPLE 1 :
Write the expression to schedule an operation 10th of August at 12:30 PM.
===========================================
'0 30 12 10 8 ?'
'0 30 12 10 AUG ?'
'0 30 12 10 AUG ? 2013'

* : Specifies all the values 


Write the expression to schedule an operation on every day of the AUG at 12:30 PM.
===========================================
'0 30 12 * AUG ?'
'0 30 12 * 8 ?'
*/
Trigger OpportunityValidation on Opportunity(before insert)
{
    if(Trigger.isInsert && Trigger.isBefore)
    CrossObjectValidation.processOpportunity(Trigger.new);
}
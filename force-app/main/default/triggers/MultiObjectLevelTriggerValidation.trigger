trigger OpportunityCaseValidationTrigger on Opportunity (before insert) {
    if(Trigger.isBefore && Trigger.isInsert) {
        OpportunityTriggerHandler.validate(Trigger.new);
    }
}

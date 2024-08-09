trigger UnderstandingTrigger on Assignment__c (before insert,after insert,before update ,
                                               after update,before delete,after delete,after undelete) 
{
if(Trigger.IsInsert & Trigger.IsBefore)
for(Assignment__c a: Trigger.New)
{
System.debug('Trigger.IsInsert & Trigger.IsBefore');
System.debug(Trigger.new); //exist
System.debug('================================================');
System.debug(Trigger.old);//null


    }
if(Trigger.IsInsert & Trigger.IsAfter)
for(Assignment__c a: Trigger.New)
{
System.debug('Trigger.IsInsert & Trigger.IsAfter');

System.debug(Trigger.new);//exist
System.debug('================================================');
System.debug(Trigger.old);//null
}
    if(Trigger.IsUpdate & Trigger.IsBefore)
for(Assignment__c a: Trigger.New)
{
System.debug('Trigger.IsUpdate & Trigger.IsBefore');

System.debug(Trigger.new);//exist with new values
System.debug('================================================');
System.debug(Trigger.old);//exist with old values
}if(Trigger.IsUpdate & Trigger.IsAfter)
for(Assignment__c a: Trigger.new)
{
System.debug('Trigger.IsUpdate & Trigger.IsAfter');

System.debug(Trigger.new);//exist with new values
System.debug('================================================');
System.debug(Trigger.old);//exist with old values
}

if(Trigger.IsDelete & Trigger.IsBefore)
for(Assignment__c a: Trigger.old)
{
System.debug('Trigger.IsDelete & Trigger.IsBefore');

System.debug(Trigger.new);//null
System.debug('================================================');
System.debug(Trigger.old);//exist with old values
}
if(Trigger.IsDelete & Trigger.IsAfter)
for(Assignment__c a: Trigger.old)
{
System.debug('Trigger.IsDelete & Trigger.IsAfter');

System.debug(Trigger.new);//null
System.debug('================================================');
System.debug(Trigger.old);//exist with old values
}
if(Trigger.IsUndelete & Trigger.IsAfter)
for(Assignment__c a: Trigger.New)
{
System.debug('Trigger.IsUndelete & Trigger.IsAfter');

System.debug(Trigger.new);//exist with previous values
System.debug('================================================');
System.debug(Trigger.old);//null
}



}
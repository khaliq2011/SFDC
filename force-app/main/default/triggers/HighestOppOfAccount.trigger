Trigger HighestOppOfAccount on Opportunity(after insert,after update,after delete)
{
List<Account> lstAccounts= new List<Account>();
List<Id> lstacc= new List<Id>();
 for(Opportunity Opp: Trigger.isDelete?trigger.old:trigger.new)
{
  system.debug('>>>'+Opp);
  lstacc.add(Opp.accountId);
  system.debug('>>>'+lstacc);

}
 for(Account a:[SELECT Id,Max_Amount__c,(Select id,Name,Amount From Opportunities) From Account where Id In :lstacc])
{
  system.debug('><><'+a.Opportunities);

  Double value=0;
    String Name;
    if(a.Opportunities!=null)
    {
         for(Opportunity Opp: a.Opportunities)
          { 

           if(value<Opp.Amount)
            {
         value=Opp.Amount;
            Name=Opp.Name;
          system.debug('>>>>'+Name);
             }
             else{
              system.debug('if else failed');
              }
            }
    
a.Max_Amount__c=Name;
lstAccounts.add(a);
    }


try{
update lstAccounts;
}catch(Exception e){
  System.debug('Error--'+e.getMessage());
  }
}}
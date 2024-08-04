public class UserHandler {
    @future
    public static void doUpdate(Set<Id> lstUser)
    {
        Map<Id,Id> mapUserManagerId = new Map<Id,Id>();
    
    List<Opportunity> lst = new List<Opportunity>();

 for(User u: [Select id, ManagerId from user where id in:lstUser ])
{ 
   mapUserManagerId.put(u.id,u.ManagerId);
}

for(Opportunity opp:[Select Id,ownerId,Stagename From Opportunity where stagename='Qualification' ANd ownerid in: lstUser])
{
       Id managerFetchedId=mapUserManagerId.get(opp.ownerId);
       opp.ownerid=managerFetchedId;
lst.add(opp);


     
}
update lst;
    System.debug('Success'+lst);
    }

}
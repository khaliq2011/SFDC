public class UserHandler {
    @future
    public static void doUpdate(Set<Id> lstUser) {
        Map<Id, Id> mapUserManagerId = new Map<Id, Id>();
        List<Opportunity> lst = new List<Opportunity>();

        for(User u : [SELECT Id, ManagerId FROM User WHERE Id IN :lstUser]) {
            mapUserManagerId.put(u.Id, u.ManagerId);
        }

        for(Opportunity opp : [SELECT Id, OwnerId, StageName FROM Opportunity WHERE StageName = 'Qualification' AND OwnerId IN :lstUser]) {
            Id managerFetchedId = mapUserManagerId.get(opp.OwnerId);
            opp.OwnerId = managerFetchedId;
            lst.add(opp);
        }

        update lst;
        System.debug('Success: ' + lst);
    }
}


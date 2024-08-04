public class PermissionSetAssigner {
    @future
    public static void assignPermissionSet(Set<Id> UserIds)
    {
        System.debug(UserIds);
        PermissionSet PermSet= [Select id,Name From Permissionset where Name='Access_to_Contacts' LIMIT 1];
                System.debug(PermSet);

        
        List<PermissionSetAssignment> lst = new List<PermissionSetAssignment>();
            for(Id u: UserIds)
        {

        PermissionSetAssignment 	pst = new PermissionSetAssignment();
            pst.AssigneeId=u;
            pst.PermissionSetId=PermSet.id;
            lst.add(pst);
            System.debug(lst);

     
        }
        
        if(!lst.isEmpty())
        {
            insert lst;
            System.debug(lst);
            System.debug('success'+lst[0].id);
        }
        
        
    }

}
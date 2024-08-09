public with sharing class PermissionSetToUser {
    public static void assignment(List<User> listOfUsers) {
        Id profileInstanceId = [SELECT Id FROM Profile WHERE Name = 'CIS Salesforce Profile' LIMIT 1].Id;
        Set<Id> setUser = new Set<Id>();

        for(User u : listOfUsers) {
            if(u.ProfileId == profileInstanceId) {
                setUser.add(u.Id);
            }
        }

        if(setUser != null && !setUser.isEmpty()) {
            PermissionSetAssigner.assignPermissionSet(setUser);
        }
    }
}

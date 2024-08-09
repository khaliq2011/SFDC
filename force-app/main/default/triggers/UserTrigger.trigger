trigger UserTrigger on User (after insert, after update) {
    if(Trigger.isInsert && Trigger.isAfter) {
        PermissionSetToUser.assignment(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        UserHandler.doUpdate(Trigger.oldMap.keySet());
    }
}

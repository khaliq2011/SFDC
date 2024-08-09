trigger AccountTrigger on Account (before delete) {
    PreventAccountDeletion.preventDelete(Trigger.oldMap);
}
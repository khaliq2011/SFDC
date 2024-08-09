trigger ContactTrigger on Contact (after delete, after insert, after update) {
    Set<Id> accIds = new Set<ID>();    
    for(Contact c : Trigger.isUpdate || Trigger.isInsert ? Trigger.new : Trigger.old) {
        if(Trigger.isUpdate) {
            Contact con = Trigger.oldMap.get(c.Id);
            if(con.AccountId != null) accIds.add(con.AccountId);
        }

        if(c.AccountId != null) accIds.add(c.AccountId);
    }

    if(!accIds.isEmpty()) {
        ContactAmountRollupOnAccount.rollupAmount(accIds);
    }
}





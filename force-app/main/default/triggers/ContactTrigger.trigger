Trigger ContactTrigger ON Contact(AFTER INSERT, AFTER UPDATE, AFTER DELETE) {

    Set <Id> accids = new Set <Id> ();

    for (Contact c: Trigger.isInsert || Trigger.isUpdate ? Trigger.new : Trigger.old) {
        if (c.AccountId != null) {
            System.debug('In trigger');

            accids.add(c.AccountId);
            if (Trigger.isUpdate) {
                Contact oldCon = Trigger.oldMap.get(c.Id);
                accids.add(oldCon.AccountId);
                accids.add(oldCon.AccountId);

            }
        }
    }


    if (!accids.isEmpty()) {
        System.debug('sent to class from trigger');

        ContactAmountRollUpOnAccount.rollupAmount(accids);

    }
}

trigger HighestOppOfAccount on Opportunity (after insert, after update, after delete) {
  List<Id> lstAcc = new List<Id>();
  for(Opportunity opp : Trigger.isDelete ? Trigger.old : Trigger.new) {
      lstAcc.add(opp.AccountId);
  }
  MaxAmountOnAccount.calculateMaxAmount(lstAcc);
}
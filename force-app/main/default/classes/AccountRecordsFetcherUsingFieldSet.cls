public without sharing class AccountRecordsFetcherUsingFieldSet {
 @AuraEnabled
 (cacheable=true)
 public static List<Account> getAccount()
 {
    String query='Select Id';
    String contquery='(Select Id';
    for(Schema.FieldSetMember fieldSet : SObjectType.Account.FieldSets.Account_Field_Set.getFields())
    {  
        query =query+(','+fieldSet.getFieldPath());
    } 
    for(Schema.FieldSetMember fieldSet : SObjectType.Contact.FieldSets.ContactFields.getFields())
    {  
        contquery =contquery+(','+fieldSet.getFieldPath());
    } 
    query =query+','+contquery+(' FROM Contacts ) FROM Account LIMIT 10');

    return Database.query(query);

}

}
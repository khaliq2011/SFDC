public without sharing class AccountController{
    @AuraEnabled
    public static void createAccounts(List<Account> accounts) {
        system.debug('accounts' + accounts);
        if(!accounts.isEmpty())
        {
            insert accounts;
            
            for(Account act:accounts)
            {
                //Contact Creation logic
                //or other logic
            }
        }
    }
    
    @AuraEnabled
    public static List<String> getPickList(String objectName, String fieldName) {
        List<String> values = new List<String>();
        //Alternative
        //List<Schema.DescribeSobjectResult> results = Schema.describeSObjects(new List<String>{objectName});
        List<String> objectNames = new List<String>();

            // Step 2: Add the objectName to the list
            objectNames.add(objectName);

             // Step 3: Use the list in the Schema.describeSObjects method
             List<Schema.DescribeSobjectResult> results = Schema.describeSObjects(objectNames);
        
        for(Schema.DescribeSobjectResult res : results) {
            for (Schema.PicklistEntry entry : res.fields.getMap().get(fieldName).getDescribe().getPicklistValues()) {
                if (entry.isActive()) {
                    values.add(entry.getValue());
                }
            }
        }
        return values;
    }
}
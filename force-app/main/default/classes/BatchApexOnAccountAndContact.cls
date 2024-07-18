global class BatchApexOnAccountAndContact implements Database.Batchable<SObject> {

    global Database.queryLocator start(Database.BatchableContext bc) {
        String q = 'SELECT ID, NAME, Judgement_Day__c, (SELECT ID,AccountId, LASTNAME FROM CONTACTS) FROM ACCOUNT WHERE Judgement_Day__c = TODAY';
        return Database.getQueryLocator(q);
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Task> taskList = new List<Task>();
        Map<Id, List<Id>> accountContactMap = new Map<Id, List<Id>>();
        Map<Id, List<Id>> failedAccountContactMap = new Map<Id, List<Id>>();

        for (Account acc : scope) {
            List<Id> contactIds = new List<Id>();
            if (acc.Contacts != null && !acc.Contacts.isEmpty()) {
                for (Contact c : acc.Contacts) {
                    contactIds.add(c.Id);
                    Task t = new Task();
                    t.Subject = 'Email';
                    t.ActivityDate = Date.today().addDays(2);
                    t.WhatId = c.AccountId;
                    t.OwnerId = '0052v00000gXLA1AAO';
                    t.Status = 'Not Started';
                    t.WhoId = c.Id;
                    taskList.add(t);
                }
                accountContactMap.put(acc.Id, contactIds);
            }
        }

        if (!taskList.isEmpty()) {
            try {
                Database.SaveResult[] results = Database.insert(taskList, false);
                for (Integer i = 0; i < results.size(); i++) {
                    Database.SaveResult result = results[i];
                    Task t = taskList[i];
                    Id accountId = t.WhatId;
                    if (result.isSuccess()) {
                        // Track successful task creations
                    } else {
                        if (!failedAccountContactMap.containsKey(accountId)) {
                            failedAccountContactMap.put(accountId, new List<Id>());
                        }
                        failedAccountContactMap.get(accountId).add(t.WhoId);
                        for (Database.Error error : result.getErrors()) {
                            System.debug('Error Status : ' + error.getStatusCode() + ' : ' + 'Error Fields : ' + error.getFields());
                        }
                    }
                }
            } catch(DMLException e) {
                throw new DMLException('Unable to Perform the DML Operation on Account : ' + e.getMessage());
            }
        }
        List<Contact> contactRecords= new List<contact>();
        List<String> conmail= new List<string>();

        // Send email logic
        for (Id accountId : accountContactMap.keySet()) {
            if (!failedAccountContactMap.containsKey(accountId)) {
                List<Id> contactIds = accountContactMap.get(accountId);
                for(Contact c:[Select id,Email from contact where id in:contactIds])
                {
 
                    c.EmailsendDateAndTime__c=DateTime.now();
                    system.debug(c.EmailsendDateAndTime__c);

                    contactRecords.add(c);
                    conmail.add(c.email);
                }
               
                // Implement your email sending logic here using contactIds
                System.debug('Send email to contacts: ' + contactIds);
            } else {
                System.debug('Failed to create tasks for all contacts of account: ' + accountId);
            }
        }
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('HIC Global Solutions');
        mail.setplaintextbody('Welcome to HIC Global Solutions');
        mail.setToAddresses(conmail);
        emailList.add(mail);
        
        if(!emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }	
        update contactRecords;
 
    }

    global void finish(Database.BatchableContext bc) {
        // Any final operations
    }
}
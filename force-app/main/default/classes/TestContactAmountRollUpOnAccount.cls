@isTest
public class TestContactAmountRollUpOnAccount {
    @isTest
    static void validateInsert() {
        Account acc = new Account(Name = 'Samad', Rating = 'Hot');
        insert acc;

        Contact con1 = new Contact(LastName = 'sameer', AccountId = acc.Id, ContactAmountOne__c = 10, ContactAmountTwo__c = 10, NoOfValues__c = 2);
        Contact con2 = new Contact(LastName = 'sameer', AccountId = acc.Id, ContactAmountOne__c = 15, ContactAmountTwo__c = 10, NoOfValues__c = 2);

        insert con1;
        insert con2;

        List <AggregateResult> aggregateResults = [
            SELECT AccountId, SUM(ContactAmountOne__c) AmountOne, SUM(ContactAmountTwo__c) AmountTwo, SUM(NoOfValues__c) NoOf
            FROM Contact
            WHERE AccountId =: acc.Id
            GROUP BY AccountId
        ];

        System.debug('Aggregate Results insert' + aggregateResults);

        System.assertEquals(25, (Decimal) aggregateResults[0].get('AmountOne'), 'Value should be 25');
        System.assertEquals(20, (Decimal) aggregateResults[0].get('AmountTwo'), 'Value should be 20');
        System.assertEquals(4, (Decimal) aggregateResults[0].get('NoOf'), 'Value should be 4');
    }

    @isTest
    static void validateUpdate() {
        validateInsert();

        Account acc = [
            SELECT Id
            FROM Account
            WHERE Name = 'Samad'
            LIMIT 1
        ];
        List <Contact> listOfContacts = [
            SELECT Id, ContactAmountOne__c, ContactAmountTwo__c, NoOfValues__c
            FROM Contact
            WHERE AccountId =: acc.Id
        ];

        for (Contact c: listOfContacts) {
            c.ContactAmountOne__c = 12;
            c.ContactAmountTwo__c = 12;
            c.NoOfValues__c = 6;
        }
        update listOfContacts;

        List <AggregateResult> aggregateResults = [SELECT AccountId,
            SUM(ContactAmountOne__c) AmountOne,
            SUM(ContactAmountTwo__c) AmountTwo,
            SUM(NoOfValues__c) NoOf
            FROM Contact
            WHERE AccountId =: acc.Id
            GROUP BY AccountId
        ];

        System.debug('after Update: ' + aggregateResults);

        System.assertEquals(24, (Decimal) aggregateResults[0].get('AmountOne'), 'Value should be 24');
        System.assertEquals(24, (Decimal) aggregateResults[0].get('AmountTwo'), 'Value should be 24');
        System.assertEquals(12, (Decimal) aggregateResults[0].get('NoOf'), 'Value should be 12');
    }

    @isTest
    static void validateDelete() {
        validateInsert();

        Account acc = [SELECT Id FROM Account WHERE Name = 'Samad'
            LIMIT 1
        ];
        List <Contact> listOfContacts = [SELECT Id FROM Contact WHERE AccountId =: acc.Id];

        delete listOfContacts;

        List <AggregateResult> aggregateResults = [SELECT AccountId,
            SUM(ContactAmountOne__c) AmountOne,
            SUM(ContactAmountTwo__c) AmountTwo,
            SUM(NoOfValues__c) NoOf
            FROM Contact
            WHERE AccountId =: acc.Id
            GROUP BY AccountId
        ];

        System.debug('after Delete: ' + aggregateResults);

        System.assertEquals(0, aggregateResults.size(), 'There should be 0 results ');
    }
}
@isTest
public class TestContactTrigger {
	@TestSetup
	static void InsertRecords() {
		Account acc = TestDataFactory.createAccount();

		// Id AccountId,Number AmountOne,Number AmountTwo,Number
		// NoOfValues,String LastName
		Contact con1 = TestDataFactory.createContact(acc.id, 12, 10, 2, 'sameer');
		Contact con2 = TestDataFactory.createContact(acc.id, 15, 10, 2, 'sharath');
	}


	@isTest
	static void validateInsert() {
		Account AccountFetched = [
			SELECT id, AccountAmountOne__c, AccountAmountTwo__c, NoOfValues__c
			FROM Account
			WHERE Name = 'Test Account'
		];

		System.debug('Results insert' + AccountFetched);

		System.assertEquals(27, AccountFetched.AccountAmountOne__c, 'Value should be 27');
		System.assertEquals(20, AccountFetched.AccountAmountTwo__c, 'Value should be 20');
		System.assertEquals(4, AccountFetched.NoOfValues__c, 'Value should be 4');
	}



	@isTest
	static void validateUpdate() {
		Account acc = [
			SELECT
				Id,
				(
					SELECT id, ContactAmountOne__c, ContactAmountTwo__c, NoOfValues__c
					FROM Contacts
				)
			FROM Account
			WHERE Name = 'Test Account'
			LIMIT 1
		];

		List<Contact> listOfContacts = new List<Contact>();
		for (Contact c : acc.Contacts) {
			c.ContactAmountOne__c = 12;
			c.ContactAmountTwo__c = 15;
			c.NoOfValues__c = 4;
			listOfContacts.add(c);
		}

		update listOfContacts;

		Account AccountFetched = [
			SELECT id, AccountAmountOne__c, AccountAmountTwo__c, NoOfValues__c
			FROM Account
			WHERE Name = 'Test Account'
		];

		System.debug('Results insert' + AccountFetched);

		System.assertEquals(24, AccountFetched.AccountAmountOne__c, 'Value should be 24');
		System.assertEquals(30, AccountFetched.AccountAmountTwo__c, 'Value should be 30');
		System.assertEquals(8, AccountFetched.NoOfValues__c, 'Value should be 8');
	}

    
	@isTest
	static void validateDelete() {
		Account acc = [
			SELECT Id
			FROM Account
			WHERE Name = 'Test Account'
			LIMIT 1
		];
		List<Contact> listOfContacts = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];

		delete listOfContacts;

		Account AccountFetched = [
			SELECT id, AccountAmountOne__c, AccountAmountTwo__c, NoOfValues__c
			FROM Account
			WHERE id = :acc.id
		];

		System.debug('after Delete: ' + AccountFetched);

		System.assertEquals(0, AccountFetched.AccountAmountOne__c, 'Value should be 0');
		System.assertEquals(0, AccountFetched.AccountAmountTwo__c, 'Value should be 0');
		System.assertEquals(0, AccountFetched.NoOfValues__c, 'Value should be 0');
	}
}
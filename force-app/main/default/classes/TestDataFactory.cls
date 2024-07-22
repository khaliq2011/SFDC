@isTest
public with sharing class TestDataFactory {
	public static Account createAccount() {
		Account acc = new Account(Name = 'Test Account', Rating = 'Hot');

		insert acc;
		return acc;
	}

	public static Contact createContact(
		Id AccountId,
		Decimal AmountOne,
		Decimal AmountTwo,
		Decimal NoOfValues,
		String LastName
	) {
		{
			Contact con = new Contact(
				LastName = LastName,
				ContactAmountOne__c = AmountOne,
				ContactAmountTwo__c = AmountTwo,
				NoOfValues__c = NoOfValues,
				accountid = AccountId
			);

			insert con;
			return con;
		}
	}
}
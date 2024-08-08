import { LightningElement} from 'lwc';
import { createRecord } from "lightning/uiRecordApi";

export default class AccountManagerLDS extends LightningElement {
    accountName;
    accountPhone;
    accountWebsite;
    accountType;
    expirationDate;
    response1;

    accountNameChangeHandler(event){
        this.accountName = event.target.value;
    }

    accountPhoneChangeHandler(event){
        this.accountPhone = event.target.value;
    }

    accountWebsiteChangeHandler(event){
        this.accountWebsite = event.target.value;
    }

    accountTypeChangeHandler(event){
        this.accountType = event.target.checked;
    }
    accountRevenueChangeHandler(event){
        this.expirationDate = event.target.value;
    }
    createAccount(){
        const fields = {'Name' : this.accountName, 'Phone' : this.accountPhone, 'Website': this.accountWebsite,'are_both_addresses_same__c':this.accountType,'SLAExpirationDate__c':this.expirationDate};
        const recordInput = {apiName : 'Account', fields};

        createRecord(recordInput).then(response => {
            this.response1=response;
            console.log('Account has been created : ', response.id);
        }).catch(error =>{
            console.error('Error in creating account : ', error.body.message);
        });
    }

}
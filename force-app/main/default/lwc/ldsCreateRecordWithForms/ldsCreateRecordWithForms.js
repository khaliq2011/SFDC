import { LightningElement } from 'lwc';

export default class LdsCreateRecordWithForms extends LightningElement {
    fieldArray=['Name','Emailaccount__c','Rating','AccountSource','Industry','Active__c','Phone','Description'];
    recid;
    doShow(e)
    {
        this.recid=e.detail.id;
    }
}
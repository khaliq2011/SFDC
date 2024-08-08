import { LightningElement, wire } from 'lwc';
import { createRecord, getRecord } from 'lightning/uiRecordApi';

const fieldArray = ['Account.Name', 'Account.Industry', 'Account.Rating', 'Account.Active__c', 'Account.Description', 'Account.Phone', 'Account.AccountSource','Account.Id'];

export default class LdsCreateRecord extends LightningElement {
    name;
    picklist;
    industry;
    description;
    isActive;
    phone;
    source;
    recid;

    // Wire method to fetch the record based on the recordId
    @wire(getRecord, { recordId: '$recid', fields: fieldArray }) accRecord;

    // Event handlers to capture input field values
    nameHandler(e) {
        this.name = e.target.value;
    }

    picklistHandler(e) {
        this.picklist = e.target.value;
    }

    industryHandler(e) {
        this.industry = e.target.value;
    }

    descriptionHandler(e) {
        this.description = e.target.value;
    }

    phoneHandler(e) {
        this.phone = e.target.value;
    }

    checkboxHandler(e) {
        this.isActive = e.target.value;
    }

    sourceHandler(e) {
        this.source = e.target.value;
    }

    // Method to save the record
    saveRecord() {
        const fields = {
            Name: this.name,
            Industry: this.industry,
            Rating: this.picklist,
            Description: this.description,
            Phone: this.phone,
            Active__c: this.isActive,
            AccountSource: this.source
        };
        const recordInput = { apiName: 'Account', fields };

        createRecord(recordInput)
            .then(response => {
                console.log(response.id);
                this.recid = response.id;
            })
            .catch(error => {
                console.log(error.body.message);
            });
    }

    // Getters to retrieve the field values from the wired record
    get accName() {
        return this.accRecord.data ? this.accRecord.data.fields.Name.value : '';
    }
    get accId() {
        return this.accRecord.data ? this.accRecord.data.fields.Id.value : '';
    }

    get accRating() {
        return this.accRecord.data ? this.accRecord.data.fields.Rating.value : '';
    }

    get accIndustry() {
        return this.accRecord.data ? this.accRecord.data.fields.Industry.value : '';
    }

    get accDescription() {
        return this.accRecord.data ? this.accRecord.data.fields.Description.value : '';
    }

    get accPhone() {
        return this.accRecord.data ? this.accRecord.data.fields.Phone.value : '';
    }

    get accActive() {
        return this.accRecord.data ? this.accRecord.data.fields.Active__c.value : '';
    }

    get accSource() {
        return this.accRecord.data ? this.accRecord.data.fields.AccountSource.value : '';
    }
}

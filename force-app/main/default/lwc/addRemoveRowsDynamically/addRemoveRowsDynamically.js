import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AddRemoveRowsDynamically extends LightningElement {
    @track ListOfItems = [{ id: 0 }];
    @track createdRecords = [];  // To store created records
    keyindex = 0;
    showModal=false;

    addRow() {
        this.keyindex++;
        this.ListOfItems.push({ id: this.keyindex });
    }

    deleteRow(event) {
        if (this.ListOfItems.length > 1) {
            this.ListOfItems = this.ListOfItems.filter(element => element.id !== parseInt(event.target.dataset.id));
        }
    }

    handleSave() {
        let isValid = true;

        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            if (!element.reportValidity()) {
                isValid = false;
            }
        });

        if (isValid) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                element.submit();
            });
        }
    }

    handleSuccess(event) {
        const recordId = event.detail.id;
        const fields = event.detail.fields;

        this.showToast();

        // Store the created record's information
        this.createdRecords.push({
            id: recordId,
            name: fields.Name.value,
            Email__c: fields.Email__c.value,
            Phone__c: fields.Phone__c.value,
            Email_Opt_Out__c: fields.Email_Opt_Out__c.value
        });
    }

    showToast() {
        this.showModal=!this.showModal;
        const event = new ShowToastEvent({
            title: 'Successfully Created',
            message: 'Contact Record has been created',
            variant: 'success',
            mode: 'pester'
        });
        this.dispatchEvent(event);
    }

    resetValues() {
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            element.value = null;
        });
    }
}

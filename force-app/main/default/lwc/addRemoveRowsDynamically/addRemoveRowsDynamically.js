import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class AddRemoveRowsDynamically extends LightningElement {
    @track ListOfItems = [

        {
            id: 0
        }


    ]
    keyindex = 0;

    addRow() {
        console.log('addRow');
        this.keyindex++;
        this.ListOfItems.push({ id: this.keyindex });
        console.log(this.ListOfItems);

    }

    deleteRow(event) {
        console.log(parseInt(event.target.dataset.id));
        if (this.ListOfItems.length > 1)
            this.ListOfItems = this.ListOfItems.filter(element => element.id !== parseInt(event.target.dataset.id));
    }

    handleSave() {
        const isValid = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            if (!element.reportValidity())
                isValid = false;
        });

        if (isValid) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => element.submit()
            );
            this.showToast();
        }
        console.log(
            '><><><</></>error');
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Successfully Created',
            message:
                'Contact Record has been created',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }
    resetValues() {
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            if (element.value == 'checked')
                element.value = unchecked;
            element.value = null;
        }
        )
    }
}
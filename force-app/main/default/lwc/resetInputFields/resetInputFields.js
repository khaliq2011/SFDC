import { LightningElement } from 'lwc';

export default class ResetInputFields extends LightningElement {
    handleClick=()=>
    {
        this.template.querySelectorAll('lightning-input-field').forEach(element=>
            {

                element.value=null;
            });
    }
}
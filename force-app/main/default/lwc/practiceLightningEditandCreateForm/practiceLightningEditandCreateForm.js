import { LightningElement } from 'lwc';

export default class PracticeLightningEditandCreateForm extends LightningElement {
   recId;
    getId(e)
    {
        this.recId=e.detail.id;
    }
}
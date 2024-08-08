import { LightningElement } from 'lwc';
export default class LightningBaseCompEditAndCreateForm extends LightningElement {
    
    recId;
    sendId(e)
    {
        this.recId=e.detail.id;
        console.log("success");
        console.log(this.recId);
    }
}
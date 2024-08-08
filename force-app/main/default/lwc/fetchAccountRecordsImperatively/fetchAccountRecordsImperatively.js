import { LightningElement } from 'lwc';
import  GetAccountRecords  from '@salesforce/apex/GetAccountRecords.getAccoutrec';

export default class FetchAccountRecordsImperatively extends LightningElement {
    AccountRecords;
    NumberofAccounts;
    LikeRecords;
    getNumber(e)
    {
        this.NumberofAccounts=e.target.value;
    }
    getText(e)
    {
        this.LikeRecords=e.target.value;
    }
    fetch()
    {
        GetAccountRecords({NoOf:this.NumberofAccounts,LikeRecords:this.LikeRecords}).then(response=>{
            this.AccountRecords=response;
            console.log(this.AccountRecords);
        }).catch(error=>{
            console.log(error.body.message);});
    }
}
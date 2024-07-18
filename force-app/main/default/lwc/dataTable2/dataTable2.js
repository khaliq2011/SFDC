import { LightningElement,wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountRecordsFetcherUsingFieldSet.getAccount';

export default class DataTable2 extends LightningElement {
    accountColumns=[];
    Accounttabledata=[];
    contactcolumns=[];
    AccountArray=[];
    get rows()
    {
        console.log(this.Accounttabledata);

        return this.Accounttabledata;
    }

   
 @wire(getAccount) fetchedAccounts(results)
 {
   if(results.data)
    {   
       
    this.accountColumns=Object.keys(results.data[0]).filter(key=> key!='Contacts');

       
         for(let i=0;i<results.data.length;i++)
            {
                let accountRecord=[];
                for(let j=0;j<this.accountColumns.length;j++)
                    {
                        let account=results.data[i];
                        accountRecord.push({label:this.accountColumns[j],Name:account[this.accountColumns[j]]});
                        console.log('mmm'+this.Accounttabledata);
                    }
               this.Accounttabledata.push(accountRecord);
            }
       

}

    else if(results.error)
    {
     console.log(results.error);
    }


 }   
}

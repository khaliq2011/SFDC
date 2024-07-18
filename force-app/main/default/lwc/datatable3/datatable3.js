import { LightningElement, wire, track } from 'lwc';
import getAccount from '@salesforce/apex/AccountRecordsFetcherUsingFieldSet.getAccount';
import { RefreshEvent } from 'lightning/refresh';
import { refreshApex } from '@salesforce/apex';



export default class DataTable3 extends LightningElement {
    @track columns = [];
    @track columnsofcontacts = [];
    @track tableData = [];
    @track colspanValue = 0;
    showCreateCont;
    @track contactcreate;
    contrecordid;
    results=[];

    @wire(getAccount) fetchedAccountRecords({ error, data }) {
        if (data) {
            this.results=data;
            console.log('Fetched Data: ' + JSON.stringify(data));

            // Extract column keys and set up columns
            const keysOfColumns = Object.keys(data[0]).filter(key => key !== 'Contacts');
            console.log('<<<<<<'+keysOfColumns);
          
            let columnsArray = [];
            for (let i = 0; i < keysOfColumns.length; i++) {
                columnsArray.push({ label: keysOfColumns[i], field: keysOfColumns[i] });
            }
            this.columns = columnsArray;

            // Check if there are any contacts and set up contact columns
            if (data[0].Contacts && data[0].Contacts.length > 0) {
                const keysOfContacts = Object.keys(data[0].Contacts[0]);
                const contactcreatecolumns=Object.keys(data[0].Contacts[0]).filter(key => key !== 'Id');
                this.contactcreate=contactcreatecolumns;

    
                let contactColumnsArray = [];
                for (let i = 0; i < keysOfContacts.length; i++) {
                    contactColumnsArray.push({ label: keysOfContacts[i], field: keysOfContacts[i] });
                }
                this.columnsofcontacts = contactColumnsArray;
                console.log('<<<<<<'+JSON.stringify(this.columnsofcontacts));

            }

            // Set colspan value
            this.colspanValue = this.columns.length + 1;

            // Store the data
            let tableDataArray = [];
            for (let i = 0; i < data.length; i++) {
                let account = data[i];

                console.log('account>>>>>'+account);
                let fieldsArray = [];
                for (let j = 0; j < this.columns.length; j++) {
                    fieldsArray.push({ field: this.columns[j].field, value: account[this.columns[j].field] });
                     console.log('>>>>>>>>column name  '+this.columns[j].field);
                     console.log('>>>>>>>>value in thecolumn >>>>account '+account[this.columns[j].field]);//account[Id]=>001jdncjdjcndjdc
                }
                let contactFieldsArray = [];
                if (account.Contacts) {
                    for (let k = 0; k < account.Contacts.length; k++) {
                        let contact = account.Contacts[k];
                        let contactFieldArray = [];
                        for (let l = 0; l < this.columnsofcontacts.length; l++) {
                            contactFieldArray.push({ field: this.columnsofcontacts[l].field, value: contact[this.columnsofcontacts[l].field] });
                        }
                        contactFieldsArray.push({ ...contact, fields: contactFieldArray });
                    }
                }
                tableDataArray.push({
                    ...account,
                    showContacts: false, // Initialize contact visibility state
                    fields: fieldsArray,
                    contactFields: contactFieldsArray
                });
            }
            this.tableData = tableDataArray;
        } else if (error) {
            console.error('Error fetching data: ' + JSON.stringify(error));
        }
    }

    toggleContacts(event) {
      
        const accountId = event.target.dataset.id;
        let updatedTableData = [];
        for (let i = 0; i < this.tableData.length; i++) {
            let account = this.tableData[i];
            if (account.Id === accountId) {
                account.showContacts = !account.showContacts;
            }
            updatedTableData.push(account);
        }
    
        this.tableData = updatedTableData;
       
    }
    
    get rows() {
        return this.tableData;
    }

    cancel() {
        this.showCreateCont = this.showCreateCont === true ? false : true;
    }
    saveCont(e)
    {    

        console.log('>><<'+e.detail.id);
        console.log('>><<'+e.target.dataset.id);

         this.contrecordid=e.detail.id?e.detail.id:e.target.dataset.id;
         this.showCreateCont=!this.showCreateCont;


    }
}

import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getAccount from '@salesforce/apex/AccountRecordsFetcherUsingFieldSet.getAccount';

export default class DataTable3 extends LightningElement {
    @track columns = [];
    @track columnsofcontacts = [];
    @track tableData = [];
    @track colspanValue = 0;
    @track showCreateCont;
    @track contactcreate;
    @track contrecordid;
    results = [];
    wiredAccountsResult;

    @wire(getAccount)
    wiredAccounts(result) {
        this.wiredAccountsResult = result;
        if (result.data) {
            this.processData(result.data);
        } else if (result.error) {
            console.error('Error fetching data: ' + JSON.stringify(result.error));
        }
    }

    processData(data) {
        this.results = data;
        console.log('Fetched Data: ' + JSON.stringify(data));

        const keysOfColumns = Object.keys(data[0]).filter(key => key !== 'Contacts');
        console.log('<<<<<<' + keysOfColumns);

        let columnsArray = [];
        for (let i = 0; i < keysOfColumns.length; i++) {
            columnsArray.push({ label: keysOfColumns[i], field: keysOfColumns[i] });
        }
        this.columns = columnsArray;

        if (data[0].Contacts && data[0].Contacts.length > 0) {
            const keysOfContacts = Object.keys(data[0].Contacts[0]);
            console.log('keys' + keysOfContacts);
            const contactcreatecolumns = Object.keys(data[0].Contacts[0]).filter(key => key !== 'Id');
            console.log('contactcreatecolumns' + contactcreatecolumns);

            this.contactcreate = contactcreatecolumns;

            let contactColumnsArray = [];
            for (let i = 0; i < keysOfContacts.length; i++) {
                contactColumnsArray.push({ label: keysOfContacts[i], field: keysOfContacts[i] });
            }
            this.columnsofcontacts = contactColumnsArray;
            console.log('<<<<<<' + JSON.stringify(this.columnsofcontacts));
        }

        this.colspanValue = this.columns.length + 1;

        let tableDataArray = [];
        for (let i = 0; i < data.length; i++) {
            let account = data[i];
            console.log('account>>>>>' + account);
            let fieldsArray = [];
            for (let j = 0; j < this.columns.length; j++) {
                fieldsArray.push({ field: this.columns[j].field, value: account[this.columns[j].field] });
                console.log('>>>>>>>>column name  ' + this.columns[j].field);
                console.log('>>>>>>>>value in thecolumn >>>>account ' + account[this.columns[j].field]);
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
                showContacts: false,
                fields: fieldsArray,
                contactFields: contactFieldsArray
            });
        }
        this.tableData = tableDataArray;
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
        console.log('tabledata' + this.tableData);
    }

    get rows() {
        return this.tableData;
    }

    cancel() {
        this.showCreateCont = this.showCreateCont === true ? false : true;
    }

    saveCont(e) {
        console.log('>><<' + e.detail.id);
        console.log('>><<' + e.target.dataset.id);

        this.contrecordid = e.detail.id ? e.detail.id : e.target.dataset.id;
        this.showCreateCont = !this.showCreateCont;

        // Refresh data after save
        refreshApex(this.wiredAccountsResult);
    }
}

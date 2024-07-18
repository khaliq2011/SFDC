import { LightningElement, wire, track } from 'lwc';
import fetchAccount from '@salesforce/apex/FetchAccountRecords.fetchAccount';

const accountColumns = [
    { label: "Account Name", fieldName: "Name" },
    { label: "Account Id", fieldName: "Id" },
    { label: "Account Rating", fieldName: "Rating" },
    {
        type: 'button-icon',
        typeAttributes: {
            iconName: 'utility:down',
            size: 'xx-small',
            alternativeText: 'Show Contacts',
            name: 'view_contacts',
        }
    },
];

const contactColumns = [
    { label: 'Contact Name', fieldName: 'ContactName' },
    { label: 'Contact Email', fieldName: 'ContactEmail' }
];

export default class dataTableAccount extends LightningElement {
    /*
    @track columns = accountColumns;
    @track contactColumns = contactColumns;
    @track accountData;

    @wire(fetchAccount) 
    getAccRecords({ error, data }) {
        if (data) {
            this.accountData = data.map(account => ({
                ...account,
                isExpanded: false,
                _children: account.Contacts ? account.Contacts.map(contact => ({
                    ContactId: contact.Id,
                    ContactName: contact.Name,
                    ContactEmail: contact.Email
                })) : []
            }));
        } else if (error) {
            console.error('Error fetching account records:', error);
            this.accountData = []; // Ensure accountData is initialized to an empty array on error
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const rowId = event.detail.row.Id;
        if (actionName === 'view_contacts') {
            this.accountData = this.accountData.map(account => ({
                ...account,
                isExpanded: account.Id === rowId ? !account.isExpanded : false
            }));
        }
    }

    get computedAccountData() {
        return this.accountData.map(account => ({
            ...account,
            _children: account.isExpanded ? account._children : []
        }));
    }
        */
}
    
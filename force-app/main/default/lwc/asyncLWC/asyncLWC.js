import { LightningElement } from 'lwc';
import FetchAccountRecords from '@salesforce/apex/FetchAccountRecords.fetchAccount';
export default class AsyncLWC extends LightningElement {
    getCont;
    values;

    async doAsyncOperation() {
        console.log('start');
        console.log(this.getCont);
        this.getCont = await FetchAccountRecords();
        console.log(this.getCont);
        console.log('end');

    }
    doSome() {
        FetchAccountRecords().then(result => {
            console.log('start');
            console.log(result);

            this.values = result
            console.log(result);

            console.log('end');

        }

        )

            .catch(error => {

            }
            )
    }
}
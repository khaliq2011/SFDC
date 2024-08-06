import { LightningElement, track, wire } from 'lwc';
import getConversionRate from '@salesforce/apex/ExchangeRateHandler.getConversionRate';
import getAvailableCurrencies from '@salesforce/apex/ExchangeRateHandler.getAvailableCurrencies';

export default class ExchangeRateConverter extends LightningElement {
    @track options = [];
    @track Fromvalue = '';
    @track Tovalue = '';
    @track result;
    @track inputValue;

    connectedCallback() {
        this.loadCurrencyOptions();
    }

    loadCurrencyOptions() {
        getAvailableCurrencies()
            .then(data => {
                const currencyOptions = [];
                for (const currency of data) {
                    currencyOptions.push({ label: currency, value: currency });
                }
                this.options = [...currencyOptions];
            })
            .catch(error => {
                console.error('Error fetching currency options', error);
            });
    }

    handleChangeFrom(event) {
        this.Fromvalue = event.target.value;
        this.calculateConversion();
    }

    handleChangeTo(event) {
        this.Tovalue = event.target.value;
        this.calculateConversion();
    }

    handleInputChange(event) {
        this.inputValue = event.target.value;
        this.calculateConversion();
    }

    calculateConversion() {
        if (this.Fromvalue && this.Tovalue && this.inputValue) {
            getConversionRate({ fromCurrency: this.Fromvalue, toCurrency: this.Tovalue })
                .then(rate => {
                    this.result = this.inputValue * rate;
                })
                .catch(error => {
                    console.error('Error fetching conversion rate', error);
                });
        }
    }
}

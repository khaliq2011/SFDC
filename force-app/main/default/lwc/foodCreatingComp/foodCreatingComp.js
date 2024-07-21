import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getIngredients from '@salesforce/apex/IngredientFetcher.getIngredients';
import fetchFoodInfo from '@salesforce/apex/FoodInfoFetcher.fetchFoodInfo';

export default class AddRemoveRowsDynamically extends LightningElement {
    @track ListOfItems = [{ id: 0 }];
    keyindex = 0;
    carb;
    fat;
    protein;
    fibre;
    idOfIngredient;
    @track foodOptions = [];
    @track filteredFoodOptions = [];
    selectedFood;

    addRow() {
        this.keyindex++;
        this.ListOfItems.push({ id: this.keyindex });
    }

    deleteRow(event) {
        if (this.ListOfItems.length > 1)
            this.ListOfItems = this.ListOfItems.filter(element => element.id !== parseInt(event.target.dataset.id));
    }

    handleSave() {
        let isValid = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            if (!element.reportValidity()) isValid = false;
        });

        if (isValid) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => element.submit());
            this.showToast();
        }
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Successfully Created',
            message: 'Contact Record has been created',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }

    resetValues() {
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            element.value = null;
        });
    }

    handleRecordPicker(event) {
        const index = event.target.getAttribute('data-index');
        const recordId = event.detail.recordId;

        this.idOfIngredient = recordId;

        getIngredients({ value: this.idOfIngredient })
            .then(result => {
                this.template.querySelectorAll('lightning-input-field').forEach(element => {
                    const elementIndex = element.getAttribute('data-index');
                    if (elementIndex && elementIndex === index) {
                        switch (element.fieldName) {
                            case 'Carbohydrates__c':
                                element.value = result.Carbohydrates__c;
                                break;
                            case 'Fats__c':
                                element.value = result.Fats__c;
                                break;
                            case 'Proteins__c':
                                element.value = result.Proteins__c;
                                break;
                            case 'Fibre__c':
                                element.value = result.Fibre__c;
                                break;
                        }
                    }
                });
            })
            .catch(error => {
                console.error('Error fetching ingredients:', error);
            });
    }

    handleSearch(event) {
        const foodName = event.target.value;
        console.log('hi');
        if (foodName.length > 2) {
            fetchFoodInfo({ foodName })
                .then(result => {
                    this.foodOptions = result.map(food => ({
                        label: food.name,
                        value: JSON.stringify(food)
                    }));
                    this.filterOptions(foodName);
                })
                .catch(error => {
                    console.error('Error fetching food info:', error);
                });
        } else {
            this.filteredFoodOptions = [];
        }
    }

    filterOptions(foodName) {
        const lowercasedValue = foodName.toLowerCase();
        this.filteredFoodOptions = this.foodOptions.filter(option =>
            option.label.toLowerCase().includes(lowercasedValue)
        );
    }

    handleOptionClick(event) {
        console.log('brbrb');
        const foodData = JSON.parse(event.target.dataset.value);
        console.log('jrnk'+JSON.parse(event.target.dataset.value));

        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            console.log(element.getAttribute('data-index'));

            const elementIndex = element.getAttribute('data-index');
            if (elementIndex) {

                switch (element.fieldName) {
                    case 'Carbohydrates__c':
                        element.value = foodData.carbohydrates_total_g;
                        break;
                    case 'Fats__c':
                        element.value = foodData.fat_total_g;
                        break;
                    case 'Proteins__c':
                        element.value = foodData.protein_g;
                        break;
                    case 'Fibre__c':
                        element.value = foodData.fiber_g;
                        break;
                }
            }
        });
        this.filteredFoodOptions = [];
    }
}

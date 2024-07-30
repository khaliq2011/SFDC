import { LightningElement,api } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';

export default class HelloWorld extends LightningElement {
  @api greeting = 'World';
  @api reactiveValue;
  changeHandler(event) {
    this.greeting = event.target.value;
        this.dispatchEvent(new FlowAttributeChangeEvent('greeting', this.greeting));
        
  }


}
/*
// Step 1: Create a Custom Event
const event = new CustomEvent('flowAttributeChange', {
    detail: {
        attributeName: 'greeting',
        attributeValue: this.greeting
    }
});

// Step 2: Dispatch the Custom Event
this.dispatchEvent(event);

        */
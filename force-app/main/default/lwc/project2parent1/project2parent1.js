import { LightningElement,api } from 'lwc';

export default class Project2parent1 extends LightningElement {
    values = ["not clicked", "not clicked", "not clicked"];
    processInfo(event) {
        this.valuesfetched = event.detail;
        this.values = this.valuesfetched.map(

            val => {
                if (val == "success")
                    return "clicked";
                else if (val == "destructive-text")
                    return "not clicked";

            }

        )
    }
    @api resetParent()
    {
        this.values = ["not clicked", "not clicked", "not clicked"];
        this.template.querySelector("c-proj2child1").resetChild();


    }

}
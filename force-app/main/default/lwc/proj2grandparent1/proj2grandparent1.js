import { LightningElement } from 'lwc';

export default class Proj2grandparent1 extends LightningElement {
    resetAll()
    {
        this.template.querySelector("c-project2parent1").resetParent();

    }
}

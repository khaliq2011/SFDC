import { LightningElement, api } from 'lwc';

export default class ChildToParent extends LightningElement {
    @api candidates;
    @api checked = false;

    tileClicked() {
        const tileClick = new CustomEvent('tile', { detail: this.candidates});
        this.dispatchEvent(tileClick);
        console.log('c2P');
    }
}
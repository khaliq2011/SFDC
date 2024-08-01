import { LightningElement } from 'lwc';

export default class ParentToChild extends LightningElement {

    candidates = [
        { Name: "Varun", CID: 21009 },
        { Name: "Karun", CID: 210010 },
        { Name: "Sharan", CID: 210011 },
        { Name: "Suran", CID: 210081 },
        { Name: "Daren", CID: 210082 },
        { Name: "Varen", CID: 210083 }
    ];

    candidateId;
    checked = false;

    processCheckbox(event) {
        this.checked = event.target.checked;
    }

    tileClickHandler(event) {
        this.candidateId = event.detail.CID;
        this.candidateName=event.detail.Name;
        console.log(this.CandidateId);
    }
}
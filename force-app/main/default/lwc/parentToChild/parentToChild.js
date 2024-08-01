import { LightningElement } from 'lwc';

export default class ParentToChild extends LightningElement {

    Candidates = [
        { Name: "Varun", CID: 21009 },
        { Name: "Karun", CID: 210010 },
        { Name: "Sharan", CID: 210011 },
        { Name: "Suran", CID: 210081 },
        { Name: "Daren", CID: 210082 },
        { Name: "Varen", CID: 210083 }
    ];

    CandidateId;
    Checked = false;

    processCheckbox(event) {
        this.Checked = event.target.checked;
    }

    tileClickHandler(event) {
        this.CandidateId = event.detail.CID;
        this.CandidateName=event.detail.Name;
        console.log(this.CandidateId);
    }
}

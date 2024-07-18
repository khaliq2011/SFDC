import { LightningElement,api } from 'lwc';

export default class Proj2child1 extends LightningElement {
    @api isSelected1=false;
    BoxName;
    className1="destructive-text";
    className2="destructive-text";
    className3="destructive-text";
    label1="Eww change my colour";
    label2="Eww change my colour";
    label3="Eww change my colour";

    isClicked=false;

   
   clickProcessor(event)
   {
    this.BoxName=event.target.name;
    console.log(event.target.name);

   
    if(this.BoxName)
        {
            if(this.BoxName=="Box1")
           { this.className1=this.className1=="destructive-text"?"success":"destructive-text";
           this.label1=this.label1=="Eww change my colour"?"Thanks":"Eww change my colour";
           }
         
            if(this.BoxName=="Box2")
                {
            this.className2=this.className2=="destructive-text"?"success":"destructive-text";
            this.label2=this.label2=="Eww change my colour"?"Thanks":"Eww change my colour";

                }
            if(this.BoxName=="Box3")
                {
            this.className3=this.className3=="destructive-text"?"success":"destructive-text";
            this.label3=this.label3=="Eww change my colour"?"Thanks":"Eww change my colour";

                }

        }

        const SendStatus= new CustomEvent('status',{detail:[this.className1,this.className2,this.className3]});
        this.dispatchEvent(SendStatus);
    
   
  

       

   
  
            }
           @api  resetChild()
    {
        this.className1="destructive-text";
        this.className2="destructive-text";
        this.className3="destructive-text";
        this.label1="Eww change my colour";
        this.label2="Eww change my colour";
        this.label3="Eww change my colour";



    }
}
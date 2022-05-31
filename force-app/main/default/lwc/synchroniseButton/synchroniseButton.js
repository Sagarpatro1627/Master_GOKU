import { LightningElement, api } from "lwc";
import callFutureClass from '@salesforce/apex/RESTApiWithlWC.callFutureClass';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class SynchroniseButton extends LightningElement {
    isExecuting = false;
    @api recordId;
    @api async invoke() {
        if (this.isExecuting) {
            return;
        }
        else{
            //alert(this.recordId);
            callFutureClass({
                extId: this.recordId
            })
            const toastEvent = new ShowToastEvent({
                title: "Contact Synchronised",
                //message: "Record ID: " + event.detail.id,
                variant: "success"
            });
            this.dispatchEvent(toastEvent);
        }
        this.isExecuting = true;
        await this.sleep(2000);
        this.isExecuting = false;
    }

  sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}
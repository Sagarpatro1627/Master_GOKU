import { LightningElement ,wire,track,api} from 'lwc';
import getContactList from '@salesforce/apex/customSearchSobjectLWC.getContactList';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
import PHONE from '@salesforce/schema/Contact.Phone';
import MAILING_CITY from '@salesforce/schema/Contact.MailingCity';
import MAILING_STATE from '@salesforce/schema/Contact.MailingState';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';
export default class SearchContacts extends NavigationMixin(LightningElement) {
    //fields to be used here in the component
    contactName='';
    objectApiName=CONTACT_OBJECT;
    fields=[FIRST_NAME,LAST_NAME,EMAIL,PHONE,MAILING_CITY,MAILING_STATE];
    //fields to be tracked throughout the process
    @track contactList;
    @track boolVisible = false;  
    @track error; 
    @track recordId;
    @track isModalOpen = false;
    @track isAddOpen=false;
    @track isEditOpen=false;
    //MODAL FOR THE DELETE CONFIRMATION
    openModal(event) {
        this.isModalOpen = true;
        this.recordId=event.target.value;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    submitDetails(event) {
        this.isModalOpen = false;
        this.callRowDelete();
    } 
    //MODAL FOR RECORD CREATION
    openAddModal(event) {
        this.isAddOpen = true;
    }
    closeAddModal() {
        this.isAddOpen = false;
    } 
    handleAddSuccess(event) {
        this.isAddOpen = false;
        const toastEvent = new ShowToastEvent({
            title: "Account created",
            //message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        this.recordReload();
    }
    //MODAL POPUP FOR EDIT RECORDS
    openEditModal(event) {
        this.isEditOpen = true;
        this.recordId=event.target.value;
    }
    closeEditModal() {
        this.isEditOpen = false;
    } 
    handleEditSuccess(event) {
        this.isEditOpen = false;
        const toastEvent = new ShowToastEvent({
            title: "Account Updated",
            //message: "Record Name: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        this.recordReload();
    }
    //FUNCTION FOR INITIALISATION
    handleButtonClick(){
        if(this.contactName!==''){
            getContactList({
                cntName: this.contactName
            })
            .then(result => {
                // set @track contacts variable with return contact list from server  
                this.contactList = result;
                const event = new ShowToastEvent({
                    title: 'Success',
                    variant: 'success',
                    message: 'Search text Found..',
                });
                this.dispatchEvent(event);
                this.boolVisible = true;
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: error.body.message,
                });
                this.dispatchEvent(event);
                // reset contacts var with null   
                this.contactList = null;
            });
        }
        else{
            // fire toast event if input field is blank
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
            this.contactList = null;
        }
    }
    //update the text after change in the input box
    handleKeyChange(event){
        this.contactName=event.target.value;
    }
    callRowView(event){
        const recId=event.target.value;
        this[NavigationMixin.Navigate]({  
            type: 'standard__recordPage',  
            attributes: {  
                recordId: recId,  
                objectApiName: 'Contact',  
                actionName: 'view'  
            }  
        }) 
    }
    //used this function to refresh the data table
    recordReload(){
        getContactList({
                cntName: this.contactName
            })
            .then(result => {
                // set @track contacts variable with return contact list from server  
                this.contactList = result;
            })
            .catch(error => { 
                this.contactList = null;
            });
        }
    callAddNewRecord(){
        this[NavigationMixin.Navigate]({
            type:'standard__objectPage',
            attributes:{
                objectApiName:'Contact',
                actionName:'new'
            }
        })
    }
    callRowEdit(event){
        const recId=event.target.value;
        this[NavigationMixin.Navigate]({  
            type: 'standard__recordPage',  
            attributes: {  
                recordId: recId,  
                objectApiName: 'Contact',  
                actionName: 'edit'  
            }  
        }) 
        this.recordReload();
    }
    callRowDelete() {
                const recId=this.recordId;
                deleteRecord(recId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
                this.recordReload();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
    
}
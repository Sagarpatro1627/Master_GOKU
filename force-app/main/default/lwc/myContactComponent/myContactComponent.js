import { LightningElement, track } from 'lwc';  
import fetchAccounts from '@salesforce/apex/searchClass.fetchAccounts';  
import { NavigationMixin } from 'lightning/navigation';  
import { refreshApex } from '@salesforce/apex';

const columns = [     
    {type: "button", typeAttributes: {  
        label: 'View',  
        name: 'View',  
        title: 'View',  
        disabled: false,  
        value: 'view',  
    }},  
    {type: "button", typeAttributes: {  
        label: 'Edit',  
        name: 'Edit',  
        title: 'Edit',  
        disabled: false,  
        value: 'edit'  
    }},
    { label: 'Name', fieldName: 'Name' },  
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Website', fieldName: 'Website' }
];  
  
export default class accountSearchLWC extends NavigationMixin(LightningElement) {  
  
    @track accounts;  
    @track error;  
    @track columns = columns;  
  
    handleKeyChange( event ) {    
        const searchKey = event.target.value;  
        if ( searchKey ) {  
            fetchAccounts( { searchKey } )    
            .then(result => {  
                this.accounts = result;  
            })  
            .catch(error => {  
                this.error = error;  
            });  
        } else  
        this.accounts = undefined;  
    }      
      
    callRowAction( event ) {  
          
        const recId =  event.detail.row.Id;  
        const actionName = event.detail.action.name;  
        if ( actionName === 'Edit' ) {  
  
            this[NavigationMixin.Navigate]({  
                type: 'standard__recordPage',  
                attributes: {  
                    recordId: recId,  
                    objectApiName: 'Account',  
                    actionName: 'edit'  
                }  
            })
          refreshApex(this.handleKeyChange(event));    
  
        } else if ( actionName === 'View') {  
  
            this[NavigationMixin.Navigate]({  
                type: 'standard__recordPage',  
                attributes: {  
                    recordId: recId,  
                    objectApiName: 'Account',  
                    actionName: 'view'  
                }  
            })  
  
        }          
  
    }  
  
}
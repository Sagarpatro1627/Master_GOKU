/*({
	clickCreateItem: function(component, event, helper) {
        let checkField = component.find('itemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(checkField){
            // Create the new expense
            let newItem = component.get("v.newItem");
            console.log("Create item: " + JSON.stringify(newItem));
            helper.createItem(component, newItem);
        }
    }
})*/
({
    
    clickCreateItem: function(component, event, helper) {    
    if(helper.validateItemForm(component)){
        // Create the new item
        var newItem = component.get("v.newItem");
        helper.createItem(component, newItem);
    	}
    }
})
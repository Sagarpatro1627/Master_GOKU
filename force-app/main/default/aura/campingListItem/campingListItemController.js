({
	/*packItem : function(component, event, helper) {
        var item = component.get("v.item",true);
        item.Packed__c = true
        component.set("v.item",item);
        event.getSource().set("v.disabled",true);
    }*/
    clickCreateItem:function(component,event,helper){
        //simplistic error checking
        var validItem=true;
        //name must not be blank
        var nameField=component.find("itemname");
        var itemname=nameField.get("v.value");
        if($A.util.isEmpty(itemname)){
            validItem=false;
            nameField.set("v.errors",[{message:"Item name can't be blank"}]);
        }
        else{
            nameField.set("v.errors,null");
        }
        
        //Quantity must not be blank
        var quantityField=component.find("quantity");
        var itemname=quantityField.get("v.value");
        if($A.util.isEmpty(itemname)){
            validItem=false;
            quantityField.set("v.errors",[{message:"Item quantity can't be blank"}]);
        }
        else{
            quantityField.set("v.errors,null");
        }
        
        //Price must not be blank
        var priceField=component.find("quantity");
        var itemname=priceField.get("v.value");
        if($A.util.isEmpty(itemname)){
            validItem=false;
            priceField.set("v.errors",[{message:"Item price can't be blank"}]);
        }
        else{
            priceField.set("v.errors,null");
        }
        if(validItem){
            var newItem = component.get("v.newItem");
            console.log("Create item: " + JSON.stringify(newItem));
            //helper.createItem(component, newItem);
            //        var theItems = component.get("v.items");
 
        // Copy the item to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newItem = JSON.parse(JSON.stringify(item));
 
        console.log("Items before 'create': " + JSON.stringify(theItems));
		theExpenses.push(newItem);
		component.set("v.expenses", theItems);
		console.log("Items after 'create': " + JSON.stringify(theItems));
        theItems.push(newItem);
        component.set("v.items", theItems);
        component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c',
                    'Name': '',
                    'Quantity__c': 0,
                    'Price__c': 0,
                    'Packed__c': false });
        }
    }
})
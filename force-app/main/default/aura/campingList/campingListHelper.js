({
	createItem: function(component, item) {
        this.saveExpense(component, item, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                let items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
            }
        });
    },
    updateItem: function(component, item) {
        this.saveExpense(component, item);
    },
    saveItem: function(component, item, callback) {
        let action = component.get("c.saveItem");
        action.setParams({
            "items": item
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
})
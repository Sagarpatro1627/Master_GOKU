public with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        // Perform isAccessible() checking first, then
        return [SELECT Id, Name, Price__c, Packed__c, Quantity__c
                FROM Camping_Item__c];
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item) {
        // Perform isUpdateable() checking first, then
        upsert item;
        return item;
    }
}
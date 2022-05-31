public with sharing class ContactCardComponentController {
    @AuraEnabled
    public static List<Contact> getRelatedList(Id recordId) {
        return [SELECT  id, name,firstname,lastname,email,phone from Contact where AccountId=: recordId];
    }
    @AuraEnabled
	public static void updateRelatedList(List<Contact> Conlist)
     {
          if(Conlist!= null && Conlist.size()>0)
          {
               update Conlist;
          }
     } 
}
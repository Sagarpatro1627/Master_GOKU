public with sharing class searchClass {  
  
    @AuraEnabled( cacheable = true )  
    public static List< Account > fetchAccounts( String searchKey ) {  
      
        String strKey = '%' + searchKey + '%';  
        return [ SELECT Id, Name, Industry, Phone,Website FROM Account WHERE Name LIKE: strKey LIMIT 10 ];  
          
    }  
      
}
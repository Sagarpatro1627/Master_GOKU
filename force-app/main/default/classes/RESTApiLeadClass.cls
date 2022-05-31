public with sharing class RESTApiLeadClass {
    /*private ApexPages.StandardController standardController;
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    public static Id extId;
    
    public class NewAccountRequestWrapper {
        public String firstname {get; set;}
        public string lastname{get;set;}
        public String phone {get; set;}
        public string company{get;set;}
        public decimal annualrevenue{get;set;}
        public string email{get;set;}
        public string externalid{get;set;}
        
    }
    public RESTApiLeadClass(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
        extId=standardController.getId();
        Lead extRecord=[select firstname,lastname,phone,company,annualrevenue,email from Lead where id=:standardController.getId() ];
        NewAccountRequestWrapper newAccount = new RESTApiLeadClass.NewAccountRequestWrapper();
        newAccount.firstname = extRecord.FirstName;
        newAccount.lastname=extRecord.LastName;
        newAccount.phone = extRecord.Phone;
        newAccount.company=extRecord.Company;
        newAccount.annualrevenue=extRecord.AnnualRevenue;
        newAccount.email=extRecord.Email;
        newAccount.externalid=extRecord.Id;
        RESTApiLeadClass.updateAccount(newAccount);
    }
    public static PageReference updateAccount(NewAccountRequestWrapper newAccount) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:MindfulSharkApi/services/apexrest/Lead');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
        system.debug(JSON.serialize(newAccount));
        response = http.send(request); 
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Synced Successfully,Thank you!'));
        System.debug(response.getBody());
        PageReference redirectPage = new PageReference('www.google.com');
        redirectPage.setRedirect(true);
        return redirectPage;
    }*/
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    public static HttpResponse updateLead(NewLeadRequestWrapper newLead) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:MindfulSharkApi/services/apexrest/Lead');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setBody('{"newLeadRequestWrapper":'+JSON.serialize(newLead)+'}');
        //system.debug('{"newLeadRequestWrapper":'+JSON.serialize(newLead)+'}');
        response = http.send(request); 
        System.debug(response.getBody());
        return response;
    }
}
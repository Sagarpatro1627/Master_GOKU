public with sharing class RESTApiController {
    private ApexPages.StandardController standardController;
    public static Id extId;
    public RESTApiController(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
        extId=standardController.getId();
        system.debug(extId);
    }
    @future(callout=true)
    public static void callUpdateLead(){
        Lead extRecord=[select FirstName,LastName,Phone,Company,AnnualRevenue,Email FROM Lead WHERE ID=:extId];
        NewLeadRequestWrapper newLead = new NewLeadRequestWrapper();
        newLead.record=extRecord;
        newLead.externalid=extRecord.Id;
        //system.debug(newLead);
        /*newLead.firstname = extRecord.FirstName;
        newLead.lastname=extRecord.LastName;
        newLead.phone = extRecord.Phone;
        newLead.company=extRecord.Company;
        newLead.annualrevenue=extRecord.AnnualRevenue;
        newLead.email=extRecord.Email;
        newLead.externalid=extRecord.Id;*/
        RESTApiLeadClass.updateLead(newLead);
    }
}
public with sharing class RESTApiWithlWC {
    //public static Id extId;
    //public RESTApiWithlWC(Id ExtId)
    //{
        //this.extId = ExtID;
        //system.debug(extId);
    //}
    @AuraEnabled
    Public static void callFutureClass(Id extId){
        callUpdateLead(extId);
    }
    @future(callout=true)
    public static void callUpdateLead(ID extId){
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
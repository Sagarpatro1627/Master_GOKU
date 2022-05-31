public with sharing class customSearchSobjectLWC {
    public customSearchSobjectLWC(){

    }
    @AuraEnabled(cacheable=false)
    public static list<contact> getContactList(string cntName) {
        string keyString = '%'+cntName + '%';
        if(cntName!='')
		{
            return [Select id,Name,Email,FirstName,LastName,Phone,MailingCity,MailingState
            From Contact
        WHERE name LIKE : keyString];
    }
    else{
        return null;
        }
    }
}
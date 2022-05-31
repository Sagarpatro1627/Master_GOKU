public with sharing class RestApiClasses {
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    public static HttpResponse updateAccount(List<NewAccountRequestWrapper> newAccount) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:MindfulSharkApi/services/apexrest/Account');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"newAccountRequestWrapper":'+JSON.serialize(newAccount)+'}');
        response = http.send(request); 
        system.debug('{"newAccountRequestWrapper":'+JSON.serialize(newAccount)+'}');
        System.debug(response.getBody());
        return response;
    }
}
/*List<Account> accounts=new List<Account>();
for(Integer i=1;i<5;i++){
    accounts.add(new Account(Name='Test'+i,Phone='123456789'+i));
}
List<NewAccountRequestWrapper> nrc=new List<NewAccountRequestWrapper>();
for(Account a:accounts){
    NewAccountRequestWrapper newAcc=new NewAccountRequestWrapper();
    newAcc.account=a;
    newAcc.externalId='sdasdfasff';
    nrc.add(newAcc);
}
RestApiClasses.updateAccount(nrc);
 List<Account> newr=[SELECT ID, Name, Phone, Website,NumberOfEmployees,Industry FROM Account Where (LastModifiedDate= TODAY AND HOUR_IN_DAY(LastModifiedDate) > 1) OR (CreatedDate= TODAY AND HOUR_IN_DAY(CreatedDate) > 1)];
List<NewAccountRequestWrapper> newWrap=new List<NewAccountRequestWrapper>();
for(Account a:newr){
    NewAccountRequestWrapper wrap=new NewAccountRequestWrapper();
    wrap.account=a;
    wrap.externalId=a.Id;
    newWrap.add(wrap);
}
HttpResponse response=RestApiClasses.updateAccount(newWrap);
system.debug(response);
 */
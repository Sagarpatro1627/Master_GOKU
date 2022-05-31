@isTest
public class RESTApiLeadTest {
	@isTest
    public static void testMethodREST(){
       Test.setMock(HttpCalloutMock.class, new MockResponseClass());
        Lead newEnt=new Lead(FirstName='Account',LastName='account',Company='Extentia',Phone='1234567890');
        insert newEnt;
        NewLeadRequestWrapper newRecord=new NewLeadRequestWrapper();
        Test.startTest();
        HttpResponse response=RESTApiLeadClass.UpdateLead(newRecord);
        Test.stopTest();
        system.assertEquals('{"example":"test"}',response.getBody());
        system.assertEquals(200,response.getStatusCode());
        
    }
}
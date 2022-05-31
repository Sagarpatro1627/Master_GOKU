@istest
public class scheduledBatchableTest {
    @isTest
    public static void testMethodAll(){
        Test.setMock(HttpCalloutMock.class, new MockResponseClass());
        List<Account> newEnt=new List<Account>();
        for(Integer i=0;i<200;i++){
            newEnt.add(new Account(Name='Account '+i, 
                Phone='123456789'+i));
        }
        insert newEnt;
        Test.startTest();
        System.schedule('ScheduledApexTest',
            '20 30 8 10 2 ?',
            new scheduledBatchable());
        Test.stopTest();   
    }
    @isTest
    public static void testMethodREST(){
       Test.setMock(HttpCalloutMock.class, new MockResponseClass());
        List<Account> newEnt=new List<Account>();
        for(Integer i=0;i<200;i++){
            newEnt.add(new Account(Name='Account '+i, 
                Phone='123456789'+i));
        }
        insert newEnt;
        List<NewAccountRequestWrapper> newRecord=new List<NewAccountRequestWrapper>();
        for(Account a:newEnt){
            NewAccountRequestWrapper acc=new NewAccountRequestWrapper();
            acc.account=a;
            acc.externalId=a.Id;
            newRecord.add(acc);
        }
        Test.startTest();
        HttpResponse response=RestApiClasses.updateAccount(newRecord);
        Test.stopTest();
        system.assertEquals('{"example":"test"}',response.getBody());
        system.assertEquals(200,response.getStatusCode());
        
    }
}
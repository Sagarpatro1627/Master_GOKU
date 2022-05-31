@istest
public class DailyLeadProcessorTest {
    @isTest
    public static void testmethod1(){
        List<Lead> newEnt=new List<Lead>();
        for(Integer i=0;i<200;i++){
            newEnt.add(new Lead(LastName='Lead '+i, 
                Company='Lead', Status='Open - Not Contacted'));
        }
        insert newEnt;
        Test.startTest();
        System.schedule('ScheduledApexTest',
            '20 30 8 10 2 ?',
            new DailyLeadProcessor());
        Test.stopTest();
        system.assertEquals(200, [select count() from Lead where LeadSource='Dreamforce']);
    }
}
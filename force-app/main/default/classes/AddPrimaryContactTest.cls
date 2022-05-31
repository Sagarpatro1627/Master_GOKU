@isTest
public class AddPrimaryContactTest {
	@isTest
    Static void testList(){
        List<Account> tst=new List<Account>();
        for(Integer i=0;i<50;i++){
            tst.add(new Account(BillingState='CA',name='Test'+i));
        }
        insert tst;
        Contact co=new Contact();        
        co.FirstName='demo';
        co.LastName='demo';
        insert co;
        String state='CA';
        AddPrimaryContact apc=new AddprimaryContact(co,state);
        Test.startTest();
        system.enqueueJob(apc);
        Test.stopTest();
    }
}
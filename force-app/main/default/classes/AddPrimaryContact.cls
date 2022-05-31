public class AddPrimaryContact implements Queueable {
    private Contact c;
    private String state;
    public AddPrimaryContact(Contact c,String state) {
        this.c=c;
        this.state=state;
    }
    public void execute(QueueableContext context) {
        List<Account> ListAccount=[SELECT ID,NAME,(select id,FirstName,LastName from contacts)from Account where BillingState=:state limit 200];
        List<Contact> lstcontact=new List<Contact>();
        for(Account acc:ListAccount){
            Contact cont=c.clone(false,false,false,false);
            cont.AccountId=acc.id;
            lstContact.add(cont);
        }
        if(lstContact.size()>0)
        {
            insert lstContact;
        }
    }
}
public class batchableRecords implements
    Database.Batchable<sObject>,Database.AllowsCallouts{
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        //Datetime myDatetime=Datetime.now().addHours(-1);
        DateTime myDatetime = System.Now().addHours(-1);
        //List<Account> newr=[SELECT ID, Name, Phone, Website,NumberOfEmployees,Industry FROM Account Where (LastModifiedDate= TODAY AND HOUR_IN_DAY(LastModifiedDate) > 1) OR (CreatedDate= TODAY AND HOUR_IN_DAY(CreatedDate) > 1)];
        return Database.getQueryLocator('SELECT ID, Name, Phone, Website,NumberOfEmployees,Industry FROM Account Where (LastModifiedDate= TODAY AND HOUR_IN_DAY(LastModifiedDate) > 1)');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<NewAccountRequestWrapper> newRecords=new List<NewAccountRequestWrapper>();
        for (Account account : scope) {
            NewAccountRequestWrapper record=new NewAccountRequestWrapper();
            record.account=account;
            record.externalId=account.Id;
            newRecords.add(record);
        }
        RestApiClasses.updateAccount(newRecords);
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }
}
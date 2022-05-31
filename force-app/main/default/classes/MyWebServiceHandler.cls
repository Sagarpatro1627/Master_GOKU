global class MyWebServiceHandler {
    webService static string sendAccount(String name){
        List<Account> records = new List<Account>();
        records=[select Name,Phone,Website,AccountNumber,AnnualRevenue From Account where Name like:name+'%'];
        string sendRecords=(string)JSON.serialize(records);
        return sendRecords;
    }
}
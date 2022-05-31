public class MyFirstWebService{
    public static void getrecords(){
        HTTPCalloutService service=new HTTPCalloutService('MindfulSharkOrg');
        string query='SELECT+NAME+,+Phone+,+AccountNUmber+,+Website+,+AnnualRevenue+,+NumberOfEmployees+FROM+Account';
        service.setURLParameter('q',query);
        HttpResponse response=service.sendRequest();
        integer count=0;
        //map<string,Account> oldRecords=new map<string,Account>();
        List<Account> oldRecords=[select Name,Phone,AccountNumber,Website,AnnualRevenue,NumberOfEmployees from Account];
        Map<String,Account> mapRecords=new Map<String,Account>();
        for(Account a:oldRecords){
            mapRecords.put(a.Name,a);
        }
        system.debug(mapRecords);
        List<Account> AccRecord=new List<Account>();
        List<JsonResponseRecord> newJsonResponseRecord=new List<JsonResponseRecord>();
        newJsonResponseRecord=(List<JsonResponseRecord>)JSON.deserialize('['+response.getBody()+']',List<JsonResponseRecord>.class);
        for(JsonResponseRecord js:newJsonResponseRecord){
            for(Account record:js.Records){
				AccRecord.add(record);
                mapRecords.put(record.Name,record);
                count++;
            }
    	}
        system.debug(mapRecords.size());
        List<Account> updatedAccount=mapRecords.values();
        system.debug(updatedAccount);
        upsert updatedAccount;
        system.debug(count);
	}
}
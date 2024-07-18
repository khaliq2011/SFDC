public without sharing class FetchAccountRecords {
    @auraenabled(cacheable=true)
    public static  List<Account> fetchAccount()
    {
       return [Select id,Name,Rating,(Select id,Name From contacts) From Account WHERE Name!='' Order By CreatedDate Desc LIMIT 10];
    }
    
}
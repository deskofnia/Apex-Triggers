trigger FourthAssQ1 on Account (after insert, after update)
{
    List<Account> accList = [Select Id, Name from Account where Id NOT IN ( Select AccountId from Opportunity) AND Id IN : Trigger.new];
        
    List<Opportunity> oppList = new List<Opportunity>();
    
    for(Account ac : accList)
    {
        Opportunity op = new Opportunity(Name ='First Opportunity - '+ac.Name, StageName = 'Prospecting', CloseDate = date.today(), accountId = ac.id);
        oppList.add(op);
        
    }
    
    insert oppList;
}

/*Map<Id, Account> accMap = new Map<Id, Account>([Select Id, Name from Account where Id NOT IN ( Select AccountId from Opportunity)]);
        
    List<Opportunity> oppList = new List<Opportunity>();
    
    for(Account ac : Trigger.new)
    {
        if(accMap.containsKey(ac.id))
        {
            Opportunity op = new Opportunity(Name ='First Opportunity - '+ac.Name, StageName = 'Prospecting', CloseDate = date.today(), accountId = ac.id);
        	oppList.add(op);
        }
        
    }
*/
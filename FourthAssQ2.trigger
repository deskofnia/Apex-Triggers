trigger FourthAssQ2 on Opportunity (before insert)
{
    Map<String, Id> oppAccMap = new Map<String, Id>();
    //key -> opp name   value -> account name
    for(Opportunity opp: trigger.new)
    {
        oppAccMap.put(opp.name, opp.AccountId);
    }
    
    Map<String, String> oppMap = new Map<String, String>();
    
    for(Opportunity opp : [ Select Name, Id, AccountId, Account.Name from opportunity where Name =: oppAccMap.keySet()])
    {
        if(oppAccMap.get(opp.name)== opp.AccountId)  
        {
            oppMap.put(opp.Name, opp.Account.Name);
        }
    }
    
    for(Opportunity opp : trigger.new)			//using for updating the record
    {
        if(oppAccMap.containsKey(opp.Name))
        {
            opp.Name = 'Duplicate Opportunity '+opp.Name; 
        }
    }
}
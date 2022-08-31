trigger FourthAssQ4 on Account (before delete)
{
	/*
	 * Trigger.old => List<sObject> => List<Account>
	 * Trigger.oldMap => Map<id, sObject> => Map<Id, Account>
	 * keySet() => Set<Keys> => Set<id> => Set<AccountId> 
	 * 
	 * open opportunity ‐ An opportunity that has not yet been won or lost and is at any of the following 
	 * sales stages: prospecting, qualification, needs 
	 * analysis, proposal, price quote, negotiation, or review.
	 */
    Set<Id> accountIdsSet = Trigger.oldMap.keySet();
    List<Opportunity> oppList = [Select Id, AccountId, Name, StageName 
                                 from Opportunity Where AccountId IN : accountIdsSet AND StageName != 'Closed Won' AND StageName != 'Closed Lost'];
    //Approach 1 using List
    /*for(Account acc: Trigger.old)
    {
        for(Opportunity opp : oppList)
        {
            if(acc.id == opp.AccountId)
            {
                acc.addError('Can not delete Account which have related opportunity');			//not good for bulki data
            }
        }
    }
*/
    
    //Approach 2 using Map
    Map<Id, Opportunity> oppMap = new Map<id, Opportunity>();
    // Key -> AccountId , Value -> Opportunity
    
    for( Opportunity opp : oppList)
    {
        if( !oppMap.containsKey(opp.AccountId))
        {
            oppMap.put(opp.AccountId, opp);
        }
    }
    
    for( Account acc : Trigger.Old)
    {
        if(oppMap.containsKey(acc.Id))
        {
            acc.addError('Can not delete Account which have related opportunity');
        }
    }
    
    
    /* if(Trigger.isBefore && Trigger.isDelete)
    {
    	AccountTriggerHandler.handleBeforeDelete(Trigger.Old, Trigger.oldMap);
    }

*/
    
   
}
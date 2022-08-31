trigger FourthAssQ9 on Opportunity (before insert)
    {
            
        List<Opportunity> oppList = [ Select id from Opportunity where StageName != 'Closed Won' AND
                                     StageName != 'Closed Lost' AND CreatedById =: UserInfo.getUserId()];
        
        //system.debug(oppList);	
        for(Opportunity op : trigger.new)
        {
            if(oppList.size() > 2)
            {
                op.addError('Can not create more than two opportunity by a single user');
            }
        }
        
        
        
        
        
        /*
         * 
         //Prevent opportunity creation if an account has more than two open opportunity 
         
        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity opp : trigger.new)
        {
            accountIds.add(opp.AccountId);
        }
        
        Map<Id, Account> accMap = new Map<Id, Account>([Select id, (Select id, AccountId from Opportunities ) from Account where id in : accountIds ]);
        
        for(Opportunity opp : trigger.new)
        {
            if(accMap.get(opp.AccountId).Opportunities.size()>=2)
            {
                opp.addError('Can not add more than two opportunity.');
            }
        }
*/
        
    }
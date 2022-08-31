trigger FourthAssQ8 on Opportunity (before update)
{

    	/*Set <Id> TaskIds = new Set <Id> ();
        for (Task task : [SELECT WhatId FROM Task])
        {
            TaskIds.add(task.WhatId);
        }*/
		
    	List<Task> taskList = [SELECT WhatId FROM Task];
    
    	Map<Id, Task> taskMap = new Map<Id, Task>();
    
    	for( Task t : taskList)
        {
            if(!taskMap.containsKey(t.WhatId))
            {
                taskMap.put(t.WhatId, t);
            }
        }
		
    	
		for( Opportunity opp : Trigger.new)
        {
            if(Trigger.oldMap.get(opp.id).StageName != 'Closed Won' && Trigger.oldMap.get(opp.id).StageName != 'Closed Lost')
            {
                if( !taskMap.containsKey(opp.Id) && opp.StageName != Trigger.oldMap.get(opp.id).StageName)
                {
                    opp.addError('You can’t change the stage until any task is related to it.');
                }
            }
        }    
    
}
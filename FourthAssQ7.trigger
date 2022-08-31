trigger FourthAssQ7 on Opportunity (before update)
{

    List<Opportunity> oldOppList = new List<Opportunity>();
    
    for(Opportunity newOpp : trigger.new)
    {
        
        //Opportunity op = new Opportunity(name = trigger.oldmap.get(newOpp.id).name + ' BackUp', newOpp.id=trigger.oldmap.get(newOpp.id));
        //oldOppList.add(op);
    }
    
    insert oldOppList;
}
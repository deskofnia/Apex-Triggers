trigger sendSmsTrigger on Lead (after insert)
{
	List<Lead> leadList = Trigger.new;
    
    
	for(Lead l : leadList)
    {
        sendNewMsg.myMethod(l.MobilePhone, l.lastName, l.email);
    }
}
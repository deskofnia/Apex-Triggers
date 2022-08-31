trigger FourthAssQ6 on Lead (before insert, before update)
{
	if(Trigger.isBefore)
    {
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            for(lead ld : trigger.new)
            {
                if(ld.leadsource == 'Phone Inquiry')
                {
                    ld.Status = 'Closed - Converted';
                }
            }
        }
     }
    
    
    
}
trigger leadTrig on Lead (before insert,before update) 
{

    if((trigger.isinsert || trigger.isupdate)&& trigger.isbefore)
    {
        for(lead l:trigger.new)
        { if(l.Industry=='banking')
            {
                if(l.street==null||l.street=='')
                    L.street.AddError('address is required');
                
            }
           
             if(l.Industry=='finance')
            {
                if(l.Email==null||l.Email=='')
                    L.email.ADDERROR('email address is required');
                if(l.Phone==null||l.Phone=='')
                    l.Phone.adderror('phone no required');
                
            }
           
            
        }
        
        
    }
}
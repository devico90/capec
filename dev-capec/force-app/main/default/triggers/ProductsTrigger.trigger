trigger ProductsTrigger on Product2 (after insert) 
{

    if (Trigger.isAfter)
    {
        if (Trigger.isInsert)
        {
            ProductsTriggerHandler.handleAfterInsert(Trigger.new);
        }
    }

}
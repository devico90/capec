trigger ItensDoacoesTrigger on ItemDoacao__c (after insert) 
{
    if (Trigger.isInsert)
    {
        if (Trigger.isAfter)
        {
            ItensDoacoesTriggerHandler.handleAfterInsert(Trigger.new);
        }
    }
}
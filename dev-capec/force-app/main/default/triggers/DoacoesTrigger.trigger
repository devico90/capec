trigger DoacoesTrigger on Doacao__c (after update)
{
    if (Trigger.isAfter)
    {
        if (Trigger.isUpdate)
        {
            DoacoesTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}
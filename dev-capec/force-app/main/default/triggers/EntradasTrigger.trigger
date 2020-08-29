trigger EntradasTrigger on Entrada__c (before insert) 
{
    if (Trigger.isBefore)
    {
        if (Trigger.isInsert)
        {
            EntradasTriggerHandler.handleBeforeInsert(Trigger.new);
        }
    }
}
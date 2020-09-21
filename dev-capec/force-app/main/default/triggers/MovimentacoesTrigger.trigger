trigger MovimentacoesTrigger on Movimentacao__c (before insert) 
{
    if (Trigger.isBefore)
    {
        if (Trigger.isInsert)
        {
            MovimentacoesTriggerHandler.handleBeforeInsert(Trigger.new);
        }
    }
}
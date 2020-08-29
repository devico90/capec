public without sharing class ExcluirItensDoacoesQueueable implements Queueable
{
    Set<Id> ids {get; private set;}

    public ExcluirItensDoacoesQueueable(Set<Id> ids) 
    {
        this.ids = ids;
    }

    public void execute(QueueableContext context)
    {
        delete ItensDoacoesSelector.getInstance().selectById(ids);
    }
}
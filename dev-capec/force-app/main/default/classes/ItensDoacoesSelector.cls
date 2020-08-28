public without sharing class ItensDoacoesSelector 
{

    private static ItensDoacoesSelector instance = null;
    public List<ItemDoacao__c> itens {get; private set;}

    private ItensDoacoesSelector(){}

    public static ItensDoacoesSelector getInstance()
    {
        if (instance == null)
        {
            instance = new ItensDoacoesSelector();
        }

        return instance;
    }

    public List<ItemDoacao__c> selectById(Set<Id> ids)
    {
        if (itens == null)
        {
            itens = [SELECT Id FROM ItemDoacao__c WHERE Id IN :ids];
        }

        return itens;
    }

    
}

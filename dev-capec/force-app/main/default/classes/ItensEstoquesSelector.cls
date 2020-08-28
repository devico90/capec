public without sharing class ItensEstoquesSelector 
{
    private static ItensEstoquesSelector instance = null;
    public List<ItemEstoque__c> itens {get; private set;}

    private ItensEstoquesSelector(){}

    public static ItensEstoquesSelector getInstance()
    {
        if (instance == null)
        {
            instance = new ItensEstoquesSelector();
        }

        return instance;
    }

    public List<ItemEstoque__c> selectByProduto(Set<Id> ids)
    {
        if (itens == null)
        {
            itens = [
                SELECT Id, Produto__c, Quantidade__c
                FROM ItemEstoque__c
                WHERE Produto__c IN :ids
            ];
        }

        return itens;
    }
}

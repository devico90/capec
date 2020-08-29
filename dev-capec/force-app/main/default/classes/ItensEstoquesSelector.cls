public without sharing class ItensEstoquesSelector 
{

    public static List<ItemEstoque__c> selectByProduto(Set<Id> ids)
    {
        if (ids.isEmpty())
        {
            return null;
        }

        return [
            SELECT Id, Produto__c, Quantidade__c
            FROM ItemEstoque__c
            WHERE Produto__c IN :ids
        ];
    }
}

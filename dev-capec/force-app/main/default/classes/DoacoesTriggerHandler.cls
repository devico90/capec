public without sharing class DoacoesTriggerHandler 
{
    public static void handleAfterUpdate(List<Doacao__c> records, Map<Id, Doacao__c> oldRecords)
    {
        Set<Id> ids = new Set<Id>();

        for (Doacao__c record : records)
        {
            if (record.Status__c.equals('Cancelada') && !record.Status__c.equals(oldRecords.get(record.Id)))
            {
                ids.add(record.Id);
            }
        }

        handleAfterUpdateEstoque(ids);
    }

    public static void handleAfterUpdateEstoque(Set<Id> idsDoacoes)
    {
        List<ItemDoacao__c> itensDoacoes = ItensDoacoesSelector.getInstance().selectByDoacaoId(idsDoacoes);
        Set<Id> idsProdutos = new Set<Id>();

        for (ItemDoacao__c item : itensDoacoes)
        {
            idsProdutos.add(item.Produto__c);
        }

        List<ItemEstoque__c> itens = ItensEstoquesSelector.getInstance().selectByProduto(idsProdutos);

        ItensEstoques ies = ItensEstoques.newInstance(itens);
        ies.devolveQuantidade(itensDoacoes);
        update ies.records;
    }
}

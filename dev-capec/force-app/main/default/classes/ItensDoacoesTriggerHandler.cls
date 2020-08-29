public without sharing class ItensDoacoesTriggerHandler
{

    public static void handleAfterInsert(List<ItemDoacao__c> records)
    {
        Map<Id, ItemDoacao__c> mapIdsProdutosItensDoacoes = new Map<Id, ItemDoacao__c>();
        Map<Id, ItemDoacao__c> mapIdsCestasBasicasItensDoacoes = new Map<Id, ItemDoacao__c>();
        Set<Id> idsToExclude = new Set<Id>();

        for (ItemDoacao__c record : records)
        {
            if (record.ProdutoRecordTypeId__c.equals(Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('CestaBasica').getRecordTypeId()))            
            {
                mapIdsCestasBasicasItensDoacoes.put(record.Produto__c, record);
                idsToExclude.add(record.Id);
            }
            else
            {
                if (!record.ItemCestaBasica__c)
                {
                    mapIdsProdutosItensDoacoes.put(record.Produto__c, record);
                }
            }
        }
        handleAfterInsertCestasBasicas(mapIdsCestasBasicasItensDoacoes, idsToExclude);
        handleAfterInsertItensNaoCestaBasica(mapIdsProdutosItensDoacoes);
    }

    public static void handleAfterInsertItensNaoCestaBasica(Map<Id, ItemDoacao__c> mapIdsProdutosItensDoacoes)
    {
        if (!mapIdsProdutosItensDoacoes.isEmpty())
        {
            ItensEstoques.newInstance(ItensEstoquesSelector.selectByProduto(mapIdsProdutosItensDoacoes.keySet())).handleDoacoes(mapIdsProdutosItensDoacoes.values());
        }

    }

    public static void handleAfterInsertCestasBasicas(Map<Id, ItemDoacao__c> mapIdsCestasBasicasItensDoacoes, Set<Id> idsToExclude)
    {
        if (!mapIdsCestasBasicasItensDoacoes.isEmpty())
        {
            insert ItensDoacoes.newInstance(mapIdsCestasBasicasItensDoacoes).createByCestaBasica();

            System.enqueueJob(new ExcluirItensDoacoesQueueable(idsToExclude));
        }
    }
}
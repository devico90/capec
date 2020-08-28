public without sharing class ItensDoacoesTriggerHandler
{    
    public static void handleAfterInsert(List<ItemDoacao__c> records)
    {
        Map<Id, ItemDoacao__c> mapIdsCestasBasicasItensDoacoes = new Map<Id, ItemDoacao__c>();
        Set<Id> idsToExclude = new Set<Id>();

        for (ItemDoacao__c record : records)
        {
            if (record.ProdutoRecordTypeId__c.equals(Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('CestaBasica').getRecordTypeId()))            
            {
                mapIdsCestasBasicasItensDoacoes.put(record.Produto__c, record);
                idsToExclude.add(record.Id);
            }
        }
        handleAfterInsertCestasBasicas(mapIdsCestasBasicasItensDoacoes, idsToExclude);
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

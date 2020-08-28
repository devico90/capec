public without sharing class ItensDoacoesTriggerHandler
{    
    public static void handleAfterInsert(List<ItemDoacao__c> records)
    {
        Map<Id, ItemDoacao__c> cestaBasicaItemDoacao = new Map<Id, ItemDoacao__c>();

        for (ItemDoacao__c record : records)
        {
            if (record.ProdutoRecordTypeId__c.equals(Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('CestaBasica').getRecordTypeId()))            
            {
                cestaBasicaItemDoacao.put(record.Produto__c, record);
            }
        }

        handleAfterInsertCestasBasicas(cestaBasicaItemDoacao);
    }

    public static void handleAfterInsertCestasBasicas(Map<Id, ItemDoacao__c> cestaBasicaItemDoacao)
    {
        if (!cestaBasicaItemDoacao.isEmpty())
        {
            insert ItensDoacoes.newInstance(cestaBasicaItemDoacao.values()).createByCestaBasica(cestaBasicaItemDoacao.keySet());
        }

        delete cestaBasicaItemDoacao.values();
    }
}

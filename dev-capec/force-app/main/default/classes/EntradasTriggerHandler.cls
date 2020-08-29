public without sharing class EntradasTriggerHandler 
{

    public static void handleBeforeInsert(List<Entrada__c> records)
    {
        List<PricebookEntry> pbEntries = PricebookEntriesSelector.selectByProduto(Utils.getSetIds(records, Entrada__c.Produto__c));

        for (Entrada__c record : records)
        {
            if (record.Valor__c == null)
            {
                handleValorPadrao(record, pbEntries);
            }            
        }
    }

    private static void handleValorPadrao(Entrada__c record, List<PricebookEntry> pbEntries)
    {
        for (PricebookEntry pbEntry : pbEntries)
        {
            if (record.Produto__c.equals(pbEntry.Product2Id))
            {
                record.Valor__c = pbEntry.UnitPrice;
                break;
            }
        }

        if (record.Valor__c == null)
        {
            record.Valor__c.addError('Preencha esse campo.');
        }
    }
}

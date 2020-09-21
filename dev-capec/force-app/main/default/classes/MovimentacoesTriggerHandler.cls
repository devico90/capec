public with sharing class MovimentacoesTriggerHandler 
{

    public static void handleBeforeInsert(List<Movimentacao__c> records)
    {
        List<Movimentacao__c> entradas = new List<Movimentacao__c>();

        for (Movimentacao__c record : records)
        {
            if (
                record.RecordTypeId.equals(Movimentacoes.RECORD_TYPE_ID_ENTRADA_COMPRA)
                || record.RecordTypeId.equals(Movimentacoes.RECORD_TYPE_ID_ENTRADA_DOACAO)
            )
            {
                entradas.add(record);
            }
        }

        handleBeforeInsertEntradas(entradas);
    }

    private static void handleBeforeInsertEntradas(List<Movimentacao__c> records)
    {
        List<PricebookEntry> pbEntries = PricebookEntriesSelector.selectByProduto(Utils.getSetIds(records, Movimentacao__c.Produto__c));
        List<ItemEstoque__c> itensEstoquesList = new List<ItemEstoque__c>();

        for (Movimentacao__c record : records)
        {
            itensEstoquesList.add(ItensEstoques.newInstance().createByMovimentacaoEntrada(record));
            handleValorPadrao(record, pbEntries);
        }

        insert itensEstoquesList;
    }

    private static void handleValorPadrao(Movimentacao__c record, List<PricebookEntry> pbEntries)
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

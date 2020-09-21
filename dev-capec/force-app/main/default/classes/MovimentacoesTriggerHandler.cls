public with sharing class MovimentacoesTriggerHandler 
{

    public static void handleBeforeInsert(List<Movimentacao__c> records)
    {
        List<ItemEstoque__c> itensEstoquesList = new List<ItemEstoque__c>();

        for (Movimentacao__c record : records)
        {
            if (
                record.RecordTypeId.equals(Movimentacoes.RECORD_TYPE_ID_ENTRADA_COMPRA)
                || record.RecordTypeId.equals(Movimentacoes.RECORD_TYPE_ID_ENTRADA_DOACAO)
            )
            {
                itensEstoquesList.add(ItensEstoques.newInstance().createByMovimentacaoEntrada(record));
            }
        }
        
        insert itensEstoquesList;
    }

}

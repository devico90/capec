public interface IItensEstoques 
{
    ItensEstoques newInstance(List<ItemEstoque__c> records);
    void devolveQuantidade(List<ItemDoacao__c> itens);
    void handleDoacoes(List<ItemDoacao__c> itensDoacoes);
    ItemEstoque__c createByMovimentacaoEntrada(Movimentacao__c record);
    ItensEstoques newInstance();
}
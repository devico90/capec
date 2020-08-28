public interface IItensEstoques 
{
    ItensEstoques newInstance(List<ItemEstoque__c> records);
    void devolveQuantidade(List<ItemDoacao__c> itens);
}

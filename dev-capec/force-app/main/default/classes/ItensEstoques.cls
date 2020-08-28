public without sharing class ItensEstoques implements IItensEstoques
{
    public List<ItemEstoque__c> records;

    public ItensEstoques(List<ItemEstoque__c> records) 
    {
        this.records = records;
    }

    public static ItensEstoques newInstance(List<ItemEstoque__c> records)
    {
        return new ItensEstoques(records);
    }

    public void devolveQuantidade(List<ItemDoacao__c> itens)
    {
        for (ItemDoacao__c itemDoacao : itens)
        {
            Integer i = 0;
            ItemEstoque__c item;
            do
            {
                item = records.get(i);
                i++;
            } while (i < records.size() && !item.Produto__c.equals(itemDoacao.Produto__c));

            if (item.Produto__c.equals(itemDoacao.Produto__c))
            {
                item.Quantidade__c += itemDoacao.Quantidade__c;
            }
        }
    }

}

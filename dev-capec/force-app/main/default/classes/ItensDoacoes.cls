public with sharing class ItensDoacoes implements IItensDoacoes
{

    List<ItemDoacao__c> records;
    Map<Id, ItemDoacao__c> mapIdsCestasBasicasItensDoacoes;

    public ItensDoacoes(List<ItemDoacao__c> records) 
    {
        this.records = records;
    }

    public static ItensDoacoes newInstance(List<ItemDoacao__c> records)
    {
        return new ItensDoacoes(records);
    }

    public ItensDoacoes(Map<Id, ItemDoacao__c> mapIdsCestasBasicasItensDoacoes) 
    {
        this.mapIdsCestasBasicasItensDoacoes = mapIdsCestasBasicasItensDoacoes;
    }

    public static ItensDoacoes newInstance(Map<Id, ItemDoacao__c> mapIdsCestasBasicasItensDoacoes)
    {
        return new ItensDoacoes(mapIdsCestasBasicasItensDoacoes);
    }

    public List<ItemDoacao__c> createByCestaBasica()
    {
        if (!mapIdsCestasBasicasItensDoacoes.isEmpty())
        {
            Map<Id, Product2> cestasBasicas = new Map<Id, Product2>(ProductsSelector.getInstance().selectByCestaBasicaId(mapIdsCestasBasicasItensDoacoes.keySet()));
            Set<Id> produtosIds = getProdutosIds(cestasBasicas.values());
            List<ItemEstoque__c> itensEstoques = ItensEstoquesSelector.getInstance().selectByProduto(produtosIds);
            List<ItemDoacao__c> itens = new List<ItemDoacao__c>();

            for (ItemDoacao__c record : mapIdsCestasBasicasItensDoacoes.values())
            {
                itens.addAll(createRecords(record, cestasBasicas.get(record.Produto__c), itensEstoques));
            }

            update itensEstoques;
            return itens;
        }

        return null;
    }

    private Set<Id> getProdutosIds(List<Product2> cestasBasicas)
    {
        Set<Id> ids = new Set<Id>();

        for (Product2 cestaBasica : cestasBasicas)
        {
            for (ItemCestaBasica__c itemCestaBasica : cestaBasica.Itens2__r)
            {
                ids.add(itemCestaBasica.Item__c);
            }
        }

        return ids;
    }

    private List<ItemDoacao__c> createRecords(ItemDoacao__c cestaBasicaItemDoacao, Product2 cestaBasicaProduto, List<ItemEstoque__c> itensEstoques)
    {
        if (cestaBasicaItemDoacao != null && cestaBasicaProduto != null)
        {
            List<ItemDoacao__c> itensDoacoes = new List<ItemDoacao__c>();
            List<ItemCestaBasica__c> itensCestaBasica = cestaBasicaProduto.Itens2__r;

            for (ItemCestaBasica__c itemCestaBasica : itensCestaBasica)
            {
                ItemDoacao__c item = createRecord(itemCestaBasica, cestaBasicaItemDoacao, itensEstoques);
                itensDoacoes.add(item);
            }

            return itensDoacoes;            
        }

        return null;
    }

    private ItemDoacao__c createRecord(ItemCestaBasica__c itemCestaBasica, ItemDoacao__c cestaBasicaItemDoacao, List<ItemEstoque__c> itensEstoques)
    {
        ItemDoacao__c item = new ItemDoacao__c();    
        item.Produto__c = itemCestaBasica.Item__c;
        item.Doacao__c = cestaBasicaItemDoacao.Doacao__c;
        item.Quantidade__c = 0;

        Decimal totalDoacao = itemCestaBasica.Quantidade__c * cestaBasicaItemDoacao.Quantidade__c;

        for (ItemEstoque__c itemEstoque : itensEstoques)
        {
            if (totalDoacao == 0)
            {
                break;
            }
            else
            {
                if (itemCestaBasica.Item__c.equals(itemEstoque.Produto__c))
                {
                    if (itemEstoque.Quantidade__c > 0)
                    {
                        if (totalDoacao <= itemEstoque.Quantidade__c)
                        {
                            item.Quantidade__c += totalDoacao;
                            itemEstoque.Quantidade__c -= totalDoacao;
                            totalDoacao -= totalDoacao;
                        }
                        else
                        {
                            item.Quantidade__c += itemEstoque.Quantidade__c;
                            totalDoacao -= itemEstoque.Quantidade__c;
                            itemEstoque.Quantidade__c = 0;                        
                        }                    
                    }
                }
            }
        }   
        
        return item;
    }
}

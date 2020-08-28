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
            List<ItemDoacao__c> itens = new List<ItemDoacao__c>();

            for (ItemDoacao__c record : mapIdsCestasBasicasItensDoacoes.values())
            {
                System.debug('item doacao cesta básica: ' + record);
                itens.addAll(createRecords(record, cestasBasicas.get(record.Produto__c)));
            }
            return itens;
        }

        return null;
    }

    private List<ItemDoacao__c> createRecords(ItemDoacao__c cestaBasicaItemDoacao, Product2 cestaBasicaProduto)
    {
        System.debug('criar os registros...');
        if (cestaBasicaItemDoacao != null && cestaBasicaProduto != null)
        {
            List<ItemDoacao__c> itensDoacoes = new List<ItemDoacao__c>();
            List<ItemCestaBasica__c> itensCestaBasica = cestaBasicaProduto.Itens2__r;
            System.debug('itens da cesta basica: ' + itensCestaBasica);

            for (ItemCestaBasica__c itemCestaBasica : itensCestaBasica)
            {
                System.debug('item da cesta basica: ' + itemCestaBasica);
                ItemDoacao__c item = new ItemDoacao__c();
    
                item.Produto__c = itemCestaBasica.Item__c;
                item.Quantidade__c = itemCestaBasica.Quantidade__c * cestaBasicaItemDoacao.Quantidade__c;
                item.Doacao__c = cestaBasicaItemDoacao.Doacao__c;
        
                itensDoacoes.add(item);
            }

            return itensDoacoes;            
        }

        return null;
    }
}

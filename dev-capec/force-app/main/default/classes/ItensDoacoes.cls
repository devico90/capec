public with sharing class ItensDoacoes implements IItensDoacoes
{

    List<ItemDoacao__c> records;
    Map<Id, ItemDoacao__c> mapRecords;

    public ItensDoacoes(List<ItemDoacao__c> records) 
    {
        this.records = records;
    }

    public static ItensDoacoes newInstance(List<ItemDoacao__c> records)
    {
        return new ItensDoacoes(records);
    }

    public ItensDoacoes(Map<Id, ItemDoacao__c> mapRecords) 
    {
        this.mapRecords = mapRecords;
    }

    public static ItensDoacoes newInstance(Map<Id, ItemDoacao__c> mapRecords)
    {
        return new ItensDoacoes(mapRecords);
    }

    public List<ItemDoacao__c> createByCestaBasica(Set<Id> cestasBasicasIds)
    {
        if (!mapRecords.isEmpty())
        {
            Map<Id, ItemCestaBasica__c> itensCestasBasicas = new Map<Id, ItemCestaBasica__c>(ItensCestasBasicasSelector.getInstance().selectByCestaBasicaId(cestasBasicasIds));
            List<ItemDoacao__c> itens = new List<ItemDoacao__c>();

            for (ItemDoacao__c record : records)
            {
                Product2 produto = itensCestasBasicas.get(record.Produto__c);
                itens.add(createRecord(record, produto));
            }
            return itens;
        }

        return null;
    }

    private ItemDoacao__c createRecord(ItemDoacao__c cestaBasica, Product2 produto)
    {
        if (cestaBasica != null && produto != null)
        {
            ItemDoacao__c item = new ItemDoacao__c();
    
            item.Produto__c = produto.Id;
            item.Quantidade__c = 1;
            item.Doacao__c = cestaBasica.Doacao__c;
    
            return item;
        }

        return null;
    }
}

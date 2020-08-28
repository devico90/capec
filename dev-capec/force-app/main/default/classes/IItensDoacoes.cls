public interface IItensDoacoes 
{
    ItensDoacoes newInstance(List<ItemDoacao__c> records);
    ItensDoacoes newInstance(Map<Id, ItemDoacao__c> mapRecords);
    List<ItemDoacao__c> createByCestaBasica();
}

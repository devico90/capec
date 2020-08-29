public without sharing class PricebookEntriesSelector
{
    public static List<PricebookEntry> selectByProduto(Set<Id> ids)
    {
        return [
            SELECT Id, UnitPrice, Product2Id
            FROM PricebookEntry
            WHERE Pricebook2.IsStandard = true
        ];
    }
}

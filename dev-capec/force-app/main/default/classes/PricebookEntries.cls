public with sharing class PricebookEntries implements IPricebookEntries 
{

    List<PricebookEntry> records;

    public PricebookEntries(List<PricebookEntry> records)
    {
        this.records = records;
    }

    public static PricebookEntries newInstance()
    {
        return new PricebookEntries(new List<PricebookEntry>());
    }

    public static PricebookEntries newInstance(List<PricebookEntry> records)
    {
        return new PricebookEntries(records);
    }

    public PricebookEntry newRecord(Product2 record)
    {
        return new PricebookEntry
        (
            Pricebook2Id = Utils.getStdPriceBook().Id
            , Product2Id = record.Id
            , UnitPrice = record.PrecoPadrao__c
            , IsActive = true 
        );
    }
}

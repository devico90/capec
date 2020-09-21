public with sharing class ProductsTriggerHandler 
{

    public static void handleAfterInsert(List<Product2> records)
    {
        List<PricebookEntry> pbEntries = new List<PricebookEntry>();

        for (Product2 record : records)
        {
            pbEntries.add(PricebookEntries.newInstance().newRecord(record));
        }

        insert pbEntries;
    }

}

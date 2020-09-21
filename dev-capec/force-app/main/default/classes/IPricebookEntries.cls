public Interface IPricebookEntries 
{
    PricebookEntries newInstance(List<PricebookEntry> records);
    PricebookEntries newInstance();
    PricebookEntry newRecord(Product2 product);
}

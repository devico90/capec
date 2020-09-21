public without sharing class Utils 
{
    private static Pricebook2 stdPriceBook; 

    public static Set<Id> getSetIds(List<SObject> sObjs, Schema.SObjectField field)
    {
        Set<Id> ids = new Set<Id>();

        for (SObject sObj : sObjs)
        {
            if (sObj.get(field) != null)
            {
                ids.add( (Id) sObj.get(field) );
            }
        }
        return ids;
    }

    public static Pricebook2 getStdPriceBook() 
    {
        if (stdPriceBook == null)
        { 
            stdPriceBook = [SELECT Id FROM Pricebook2 WHERE isStandard = TRUE LIMIT 1];
        }

        return stdPriceBook;    
    }


}

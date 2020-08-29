public without sharing class Utils 
{
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
}

public without sharing class ItensCestasBasicasSelector 
{
    private static ItensCestasBasicasSelector instance = null;
    public List<ItemCestaBasica__c> itensCestasBasicas {get; private set;}

    private ItensCestasBasicasSelector(){}

    public static ItensCestasBasicasSelector getInstance()
    {
        if (instance == null)
        {
            instance = new ItensCestasBasicasSelector();
        }

        return instance;
    }

    public List<ItemCestaBasica__c> selectByCestaBasicaId(Set<Id> ids)
    {
        if (itensCestasBasicas == null)
        {
            itensCestasBasicas = [
                SELECT Id, Item__c
                FROM ItemCestaBasica__c
                WHERE CestaBasica__c IN :ids
            ];
        }

        return itensCestasBasicas;
    }
}

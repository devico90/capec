public without sharing class ProductsSelector 
{
    private static ProductsSelector instance = null;
    public List<Product2> productsCestaBasica {get; private set;}

    private ProductsSelector(){}

    public static ProductsSelector getInstance()
    {
        if (instance == null)
        {
            instance = new ProductsSelector();
        }

        return instance;
    }

    public List<Product2> selectByCestaBasicaId(Set<Id> ids)
    {
        if (productsCestaBasica == null)
        {
            productsCestaBasica = [
                SELECT Id, (SELECT Id, Item__r.Name, Quantidade__c FROM Itens2__r)
                FROM Product2
                WHERE Id IN :ids
                AND RecordTypeId = :Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('CestaBasica').getRecordTypeId()
            ];
        }

        return productsCestaBasica;
    }
}
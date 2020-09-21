public with sharing class Movimentacoes 
{
    public static FINAL Id RECORD_TYPE_ID_ENTRADA_COMPRA = Schema.SObjectType.Movimentacao__c.getRecordTypeInfosByDeveloperName().get('EntradaCompra').getRecordTypeId();
    public static FINAL Id RECORD_TYPE_ID_ENTRADA_DOACAO = Schema.SObjectType.Movimentacao__c.getRecordTypeInfosByDeveloperName().get('EntradaDoacao').getRecordTypeId();

    public Movimentacoes() {

    }
}

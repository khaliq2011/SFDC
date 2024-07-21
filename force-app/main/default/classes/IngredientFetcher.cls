public with sharing class IngredientFetcher {
    @auraenabled
    (cacheable=true)
    public static Ingredient__c getIngredients(Id value)
    {

        return [SELECT Id, Name, Proteins__c, Fibre__c, Fats__c,Carbohydrates__c FROM Ingredient__c WHERE Id =:value];

    }
    
}
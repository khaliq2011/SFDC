public with sharing class FoodInfoFetcher {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> fetchFoodInfo(String foodName) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https:' + '//api.calorieninjas.com/v1/nutrition?query=' + foodName);
        request.setMethod('GET');
        request.setHeader('X-Api-Key', 'gzRuIUa3PC+j4ACh3hJLIg==2QxtvFVNyxw7mzNA');

        HttpResponse response = http.send(request);
        List<Map<String, Object>> foods = new List<Map<String, Object>>();

        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> items = (List<Object>) results.get('items');

            for (Object item : items) {
                Map<String, Object> foodData = (Map<String, Object>) item;
                foods.add(foodData);
            }
        }
        return foods;
    }
}

public with sharing class ExchangeRateHandler {
    private static final String API_ENDPOINT = 'fca_live_QnvZ1GcvEFepSpSjuvjfs4F96vSW5kh02HHTZyuo';

    @AuraEnabled(cacheable=true)
    public static Decimal getConversionRate(String fromCurrency, String toCurrency) {
        String endpoint = 'https://api.freecurrencyapi.com/v1/latest?apikey=' + API_ENDPOINT + '&currencies=' + fromCurrency + ',' + toCurrency;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> data = (Map<String, Object>) result.get('data');

            Decimal fromRate = (Decimal) data.get(fromCurrency);
            Decimal toRate = (Decimal) data.get(toCurrency);

            Decimal conversionRate = toRate / fromRate;
            return conversionRate;
        } else {
            throw new CalloutException('Error calling Exchange Rate API: ' + response.getStatus());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getAvailableCurrencies() {
        String endpoint = 'https://api.freecurrencyapi.com/v1/latest?apikey=' + API_ENDPOINT;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> currencies = (Map<String, Object>) result.get('data');
            return new List<String>(currencies.keySet());
        } else {
            throw new CalloutException('Error fetching available currencies: ' + response.getStatus());
        }
    }
}

public with sharing class CreateBarCodeForFlow {
    @Invocablemethod (Label='Create and Send Barcode Image' callout=true)
    public static void getImage(List<Request> Requests)
    {
        for (Request r: Requests){  
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(r.imageURL);
            req.setMethod('GET');
            Http binding = new Http();
            HttpResponse res = binding.send(req);
            Integer statusCode = res.getStatusCode();

            SYstem.debug('>>>>>>>'+statusCode);
            String statusText = res.getStatus();
            SYstem.debug('>>>>>>>'+statusText);


            Blob image = res.getBodyAsBlob(); 

            
            // Creates the contentversion
            ContentVersion cv = new ContentVersion();
            cv.Title = r.fileName;
            cv.PathOnClient = r.fileName + '.jpg';
            cv.VersionData = image;
            INSERT cv;
            
            // Get the content document id from contentversion
            Id contentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
            
            //Create ContentDocumentLink and  Link the content document to a record
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = r.recordId;
            cdl.ContentDocumentId = contentDocumentId;
            cdl.shareType = 'V';
            Insert cdl;
            

        }

    }

    public class Request
    {
    @invocableVariable (Label='File Name' required=true)
    public string FileName;

    @invocableVariable (Label='Image URL' required=false)
    public string ImageURL;
    
    @invocableVariable (Label='RecordID' required=true)
    public string RecordID;

    }
    
}
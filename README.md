AFNetworking-JSONModel
======================
This is a tiny AFNetworking (https://github.com/AFNetworking/AFNetworking) extension to simplify the integration with the JSONModel parsing library (https://github.com/icanzilb/JSONModel).

In every service we pass to our AFHTTPRequestOperationManager+JsonModelRequestOperationManager category the JSONModel class we expect to receive as the API response. Any other response is automatically redirected to the same error callback we use for networking errors, so we move away the JSON error control code from every ApiClient service, making it generic.

Initialize the AFHTTPRequestOperationManager:
````objective-c
// We can save the AFHTTPRequestOperationManager instance in a Singleton to reuse it in other services
NSURL *baseUrl = [NSURL URLWithString:@"http://www.my-service.com/api/"];
AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    
````

Calling the /projects service without AFNetworking+JSONModel:
````objective-c
// ProjectListDto is a JSONModel subclass representing the expected JSON from the service
[manager GET:@"/projects" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    NSError *jsonParsingError;
    ProjectListDto *projectListDto = [[ProjectListDto alloc] initWithString:operation.responseString usingEncoding:NSUTF8StringEncoding error:&jsonParsingError];
    if (jsonParsingError) {
        // ... custom error handling ...
        onError(jsonParsingError);
        return;
    }
        
    onComplete(projectListDto);
        
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    onError(error);
}];
````

Calling the /projects service with AFNetworking+JSONModel:
````objective-c
// ProjectListDto is a JSONModel subclass representing the expected JSON from the service
[manager GET:@"/projects" parameters:nil class:[ProjectListDto class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    ProjectListDto *projectListDto = (ProjectListDto *)responseObject;
    onComplete(projectListDto);
        
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    onError(error);
}];
````


TODO
===
- Test with the newest AFNetworking & JSONModel versions and update dependecies
- NSURLSession compatibility.
- Ability to parse JSON arrays as the root object. ¿Is it acceptable to have JSON arrays not wrapped in a JSON object in a REST API?
- Serialize requests with path params. We have to take into account that we can have body params and path params in the same request and we only have a "params" parameter. Add a new pathParams parameter? In Java some libs like Retrofit solve this problem using annotations to differenciate path params, query params and body params: @Path("paramName") param, @Query("paramName") param, @Body object.

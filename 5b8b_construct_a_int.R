# Define a data model for the interactive API service generator
api_service_generator <- function(
  service_name, 
  api_endpoint, 
  request_method, 
  response_format, 
  authentication_type
) {
  # Create a list to store the API service configuration
  api_config <- list(
    service_name = service_name,
    api_endpoint = api_endpoint,
    request_method = request_method,
    response_format = response_format,
    authentication_type = authentication_type,
    endpoints = list()
  )
  
  # Function to add an endpoint to the API service
  add_endpoint <- function(endpoint_path, request_method, response_format) {
    api_config$endpoints <- c(api_config$endpoints, list(list(
      endpoint_path = endpoint_path,
      request_method = request_method,
      response_format = response_format
    )))
  }
  
  # Function to generate the API service
  generate_service <- function() {
    # Create a string to store the API service code
    service_code <- ""
    
    # Generate the API service code based on the configuration
    service_code <- paste0(service_code, "API Service: ", api_config$service_name, "\n")
    service_code <- paste0(service_code, "API Endpoint: ", api_config$api_endpoint, "\n")
    service_code <- paste0(service_code, "Request Method: ", api_config$request_method, "\n")
    service_code <- paste0(service_code, "Response Format: ", api_config$response_format, "\n")
    service_code <- paste0(service_code, "Authentication Type: ", api_config$authentication_type, "\n")
    
    # Generate the endpoint code
    for (endpoint in api_config$endpoints) {
      service_code <- paste0(service_code, "Endpoint: ", endpoint$endpoint_path, "\n")
      service_code <- paste0(service_code, "  Request Method: ", endpoint$request_method, "\n")
      service_code <- paste0(service_code, "  Response Format: ", endpoint$response_format, "\n")
    }
    
    # Return the generated API service code
    return(service_code)
  }
  
  # Return a list containing the add_endpoint function and the generate_service function
  return(list(add_endpoint = add_endpoint, generate_service = generate_service))
}

# Example usage
api_service <- api_service_generator(
  "My API Service", 
  "https://example.com/api", 
  "GET", 
  "JSON", 
  "Basic Auth"
)

api_service$add_endpoint("/users", "GET", "JSON")
api_service$add_endpoint("/users/{user_id}", "GET", "JSON")

print(api_service$generate_service())
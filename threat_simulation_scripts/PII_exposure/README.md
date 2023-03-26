# Purpose of the code
This Python code sends an HTTP POST with Personally identifiable information (PII) to an API endpoint with custom data in the request body. The code uses the http.client library to create an HTTP connection and send the request.

This code needs to be run in the <b>Gateway</b>.


## How to use the code
Ensure that Python and the http.client library are installed.
Replace 'www.example.com' in the code with the hostname of the HTTP server to which you want to send the POST request.
Replace '/api' in the code with the endpoint of the API to which you want to send the POST request.
Define the PII to be sent in the request body by adding or removing key-value pairs in the custom_data dictionary.
Run the Python script to send the POST request and receive the response from the server.


Run the Python script:

``` python3 privacy_script.py ```

The script will sleep 20 minutes, it will then run the detection script to check whether the safeguard detects the threat adding the result of the detection in a separated file.

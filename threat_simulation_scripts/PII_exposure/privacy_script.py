import http.client

# Define the HTTP server and endpoint
server = 'www.example.com'
endpoint = '/api'

# Define the custom data
custom_data = {
    'name': 'Anna',
    'age': 30,
    'email': 'anna@example.com',
    'password': 'iot',
    'info': 'private',
    'ip': '146.179.255.2',
    'credit': '5300 5454 5566 8787',
    'passport': 'YB5476777',
    'dob': '16-12-90',
    'bank': '23345676'

}

# Convert the data to a string
data_string = '&'.join([f"{key}={value}" for key, value in custom_data.items()])

# Define the headers
headers = {
    'Content-type': 'application/x-www-form-urlencoded',
    'Accept': 'text/plain'
}

# Create the HTTP connection
conn = http.client.HTTPConnection(server)

# Send the POST request with the custom data
conn.request('POST', endpoint, data_string, headers)

# Get the response
response = conn.getresponse()

# Print the response data
print(response.read())

import sys
import http.client

dest=sys.argv[1]
conn = http.client.HTTPConnection(dest, None, 3.0)
conn.request("GET", "/")
r1 = conn.getresponse()
print(dest, r1.status, r1.reason)

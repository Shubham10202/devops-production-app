from http.server import BaseHTTPRequestHandler, HTTPServer


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):

        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Application is healthy")

        else:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Hello from DevOps Production App")


server = HTTPServer(("0.0.0.0", 8080), Handler)

print("Application running on port 8080")

server.serve_forever()

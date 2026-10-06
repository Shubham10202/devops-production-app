import os
import logging
from http.server import BaseHTTPRequestHandler, HTTPServer

logging.basicConfig(
    filename="/app/logs/app.log",
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)

logger = logging.getLogger(__name__)


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Application is healthy")
            logger.info("Health check: %s", self.path)

        else:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Hello from DevOps Production App")
            logger.info("Request received: %s", self.path)


port = int(os.getenv("APP_PORT", "8080"))

server = HTTPServer(("0.0.0.0", port), Handler)

logger.info("Application starting on port %s", port)
print(f"Application running on port {port}")

server.serve_forever()




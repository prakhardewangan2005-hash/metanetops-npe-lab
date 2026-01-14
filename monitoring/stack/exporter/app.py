import os
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.getenv("EXPORTER_PORT", "9109"))

START = time.time()

def metrics_text():
    # Simple Prometheus text exposition (no external deps)
    uptime = int(time.time() - START)

    # Simulated BGP metrics (you can later wire this to real FRR output)
    bgp_sessions_established = 3
    bgp_sessions_down = 1
    prefix_count = 42000

    return f"""# HELP bgp_session_established Number of established BGP sessions
# TYPE bgp_session_established gauge
bgp_session_established {bgp_sessions_established}

# HELP bgp_session_down Number of down BGP sessions
# TYPE bgp_session_down gauge
bgp_session_down {bgp_sessions_down}

# HELP bgp_prefix_count Total prefixes learned
# TYPE bgp_prefix_count gauge
bgp_prefix_count {prefix_count}

# HELP bgp_exporter_uptime_seconds Exporter uptime in seconds
# TYPE bgp_exporter_uptime_seconds counter
bgp_exporter_uptime_seconds {uptime}
"""

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path in ("/metrics", "/metrics/"):
            body = metrics_text().encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/plain; version=0.0.4")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        elif self.path in ("/", "/health"):
            body = b"ok\n"
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, fmt, *args):
        return

if __name__ == "__main__":
    print(f"bgp_exporter listening on :{PORT}")
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()

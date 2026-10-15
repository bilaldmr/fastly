# Capture origin status for logging (req.http.x-origin-*) and keep the origin's
# own x-cache under x-cache-origin so Fastly's X-Cache isn't confused with it.
if (req.backend.is_origin) {
  set req.http.x-origin-response = beresp.response;
  set req.http.x-origin-status = beresp.status;

  if (beresp.http.x-cache) {
    set beresp.http.x-cache-origin = beresp.http.x-cache;
    set beresp.http.x-cache-origin-hits = beresp.http.x-cache-hits;
    unset beresp.http.x-cache;
    unset beresp.http.x-cache-hits;
  }
}

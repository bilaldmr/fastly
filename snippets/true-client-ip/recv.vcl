# Keep the real client IP across shielding and use it for geo lookups.
if (fastly.ff.visits_this_service == 0 && req.restarts == 0) {
  set req.http.Fastly-Client-IP = client.ip;
}
set client.geo.ip_override = req.http.fastly-client-ip;

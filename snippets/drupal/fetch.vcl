# Drop Vary: Cookie so anonymous pages share one cache object.
if (beresp.http.Vary:Cookie) {
  unset beresp.http.Vary:Cookie;
  set beresp.http.x-acquia-re-vary = "Cookie";
}

if (req.url.path ~ "^/sites/.+/files/") {
  set beresp.cacheable = true;
  set beresp.ttl = 1d;
}

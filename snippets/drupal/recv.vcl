# Drupal: send login/admin-ish paths home, pass batch + logged-in traffic.
# Requires `var.is_pass` (see README) or swap for return(pass).
if (req.url.path ~ "^/(?:index\.php|.*user/(?:password|login|register))") {
  error 601 "/";
}

if (req.url.path ~ "batch$" || req.http.Cookie ~ "(?:^|;\s*)(?:S?SESS|NO_CACHE|PERSISTENT_LOGIN_)") {
  set var.is_pass = true;
}

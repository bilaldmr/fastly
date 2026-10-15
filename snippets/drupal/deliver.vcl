# Edge only: keep browsers from caching logged-in pages and public files.
if (fastly.ff.visits_this_service == 0) {
  if (req.url.path ~ "^/sites/.+/files/" || req.http.Cookie ~ "(?:^|;\s*)(?:S?SESS|NO_CACHE|PERSISTENT_LOGIN_)") {
    set resp.http.Cache-Control = "max-age=0";
  }
  set resp.http.Vary:Cookie = "";
}

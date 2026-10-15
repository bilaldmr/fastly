# Allow cross-origin font loads.
if (req.url.ext ~ "^woff2?$") {
  set resp.http.Access-Control-Allow-Origin = "*";
}

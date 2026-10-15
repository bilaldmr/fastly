# Cloudflare-style /cdn-cgi/trace debug endpoint.
if (req.url.path == "/cdn-cgi/trace") {
  error 606;
}

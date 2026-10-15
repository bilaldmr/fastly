# Don't cache redirects built from the original URL under the normalized key.
if (req.http.x-qn-original-url
    && (beresp.status == 301 || beresp.status == 302 || beresp.status == 307 || beresp.status == 308)) {
  return (pass);
}

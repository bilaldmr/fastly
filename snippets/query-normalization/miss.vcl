# Also add as a pass snippet.
if (req.backend.is_origin && req.http.x-qn-original-url) {
  set bereq.url = req.http.x-qn-original-url;
  unset bereq.http.x-qn-original-url;
}

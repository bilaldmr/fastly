# Also add as a pass snippet.
# Edge -> shield: make sure the shield sees the image flag and runs Image Optimizer.
if (req.backend.is_shield && req.http.x-cdn-cgi-image-rewrite == "true") {
  set bereq.http.x-cdn-cgi-image-rewrite = "true";
  set bereq.http.x-fastly-imageopto-api = "fastly";
}

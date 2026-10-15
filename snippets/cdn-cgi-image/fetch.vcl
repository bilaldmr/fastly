if (req.http.x-cdn-cgi-image-rewrite == "true") {
  unset beresp.http.set-cookie;
}

if (req.http.x-redirect) {
  set obj.http.Location = if(req.http.redirect-path ~ "^https://", "", "https://" req.http.host)
    req.http.redirect-path
    if(req.http.x-qs-flag && req.url.qs != "", "?" req.url.qs, "");
  synthetic {""};
  return (deliver);
}

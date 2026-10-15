# Strip tracking params and sort the query string so they share one cache key.
# Origin still receives the original URL (see miss.vcl). At the shield the header
# comes from the edge; at the edge it is reset so clients can't choose the origin URL.
declare local var.orig_url STRING;

if (fastly.ff.visits_this_service == 0 && req.restarts == 0) {
  unset req.http.x-qn-original-url;
}

if (req.http.x-cdn-cgi-image-rewrite != "true") {
  set var.orig_url = req.url;

  set req.url = querystring.regfilter(req.url,
    "^(?i)(utm_.*|gad_.*|mc_.*|pk_.*|adjust_.*|af_.*|vero_.*|oly_.*|_branch_.*|gclid|gclsrc|gclid_aw|dclid|gbraid|wbraid|srsltid|fbclid|igshid|msclkid|ttclid|li_fat_id|twclid|xclid|sccid|epik|rdt_cid|vmcid|yclid|ymclid|yqrid|yzclid|_openstat|mkt_tok|_hsenc|_hsmi|__hssc|__hstc|hsctatracking|_kx|_ga|_gl|s_kwcid|s_cid|aff|affiliate_id|partner_id|irclickid|cjevent|awc|pid|sfmc_id)$"
  );
  set req.url = querystring.sort(req.url);
  set req.url = querystring.clean(req.url);

  if (req.url != var.orig_url && !req.http.x-qn-original-url) {
    set req.http.x-qn-original-url = var.orig_url;
  }
}

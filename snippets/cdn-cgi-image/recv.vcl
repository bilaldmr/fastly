# Translate Cloudflare /cdn-cgi/image/<opts>/<path> URLs to Fastly Image Optimizer params.
# Requires Image Optimizer enabled on the service.
if (fastly.ff.visits_this_service == 0 && req.restarts == 0) {
  unset req.http.x-cdn-cgi-image-rewrite;
  unset req.http.x-fastly-imageopto-api;
}

if (req.url.path ~ "^/cdn-cgi/image/([^/]+)(/.*)$") {
  declare local var.params STRING;
  declare local var.origin_path STRING;
  declare local var.width STRING;
  declare local var.height STRING;
  declare local var.fit STRING;
  declare local var.format STRING;
  declare local var.quality STRING;

  set var.params = re.group.1;
  set var.origin_path = re.group.2;
  set req.http.x-cdn-cgi-image-rewrite = "true";

  if (var.params ~ "(?i)(?:^|,)w(?:idth)?=(\d+)(?:,|$)") {
    set var.width = re.group.1;
  }

  if (var.params ~ "(?i)(?:^|,)h(?:eight)?=(\d+)(?:,|$)") {
    set var.height = re.group.1;
  }

  if (var.params ~ "(?i)(?:^|,)f(?:ormat)?=(\w+)(?:,|$)") {
    set var.format = std.tolower(re.group.1);
  }

  if (var.params ~ "(?i)(?:^|,)fit=([\w-]+)(?:,|$)") {
    set var.fit = std.tolower(re.group.1);
  }

  if (var.params ~ "(?i)(?:^|,)q(?:uality)?=(\d+)(?:,|$)") {
    set var.quality = re.group.1;
  }

  if (var.width) {
    set req.url = querystring.add(req.url, "width", var.width);
  }
  if (var.height) {
    set req.url = querystring.add(req.url, "height", var.height);
  }
  # fit only matters with both dimensions. Cloudflare cover/crop -> crop, everything else
  # (contain, scale-down, none) -> bounds, which keeps the aspect ratio.
  if (var.width && var.height) {
    set req.url = querystring.add(req.url, "fit", if(var.fit ~ "^(?:cover|crop)$", "crop", "bounds"));
  }

  if (var.quality) {
    set req.url = querystring.add(req.url, "quality", var.quality);
  }

  if (var.format) {
    set req.url = querystring.add(req.url, "format", var.format);
  }

  set req.url = var.origin_path + if(req.url.qs != "", "?" + req.url.qs, "");
}

if (req.http.x-cdn-cgi-image-rewrite == "true") {
  set req.http.x-fastly-imageopto-api = "fastly";
}

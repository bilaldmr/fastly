declare local var.full-request STRING;
declare local var.fsly-redir-value STRING;

set var.full-request = req.http.host req.url.path;
unset req.http.x-redirect;

set var.fsly-redir-value = table.lookup(redirects, var.full-request, "");
if (var.fsly-redir-value == "") {
  set var.fsly-redir-value = table.lookup(redirects, req.url.path, "");
}
if (var.fsly-redir-value == "") {
  call check_redirects;
  set var.fsly-redir-value = req.http.redir-value;
  unset req.http.redir-value;
  unset req.http.redir-url-path;
}

if (var.fsly-redir-value ~ "^(\d+)\|(.*)\|(.*)$") {
  set req.http.x-status = re.group.1;
  set req.http.x-qs-flag = re.group.2;
  set req.http.redirect-path = re.group.3;
  if (req.http.x-qs-flag != "keep") {
    unset req.http.x-qs-flag;
  }
  set req.http.x-redirect = "true";
  error std.atoi(req.http.x-status);
}

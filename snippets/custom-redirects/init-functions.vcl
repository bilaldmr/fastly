# Wildcard matching: walks up to 7 path segments looking for "<prefix>*" keys.
sub check_wildcard_redir_part {
  if (req.http.redir-value || std.strlen(req.http.redir-url-path) == 0) {
    return;
  }
  declare local var.star-path STRING;
  declare local var.host-star-path STRING;
  set var.star-path = req.http.redir-url-path + "*";
  set var.host-star-path = req.http.host + var.star-path;
  set req.http.redir-value = table.lookup(redirects, var.host-star-path);
  if (req.http.redir-value) {
    return;
  }
  set req.http.redir-value = table.lookup(redirects, var.star-path);
  if (req.http.redir-url-path ~ "/$") {
    set req.http.redir-url-path = regsub(req.http.redir-url-path, "[^/]*/$", "");
  } else {
    unset req.http.redir-url-path;
  }
}

sub check_redirects {
  # Never trust a client-sent value: check_wildcard_redir_part stops early if it's set.
  unset req.http.redir-value;
  if (req.url.path ~ "^(/(?:[^/]*/){0,6})") {
    set req.http.redir-url-path = re.group.1;
    call check_wildcard_redir_part;
    call check_wildcard_redir_part;
    call check_wildcard_redir_part;
    call check_wildcard_redir_part;
    call check_wildcard_redir_part;
    call check_wildcard_redir_part;
    call check_wildcard_redir_part;
  }
}

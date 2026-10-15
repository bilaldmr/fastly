# Generic: `error 601 "<location>"` -> 301 to that location.
if (obj.status == 601) {
  set obj.http.location = obj.response;
  set obj.status = 301;
  set obj.response = "Moved Permanently";
  synthetic {""};
  return(deliver);
}

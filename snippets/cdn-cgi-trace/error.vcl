if (obj.status == 606) {
  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "text/plain; charset=utf-8";
  synthetic "h=" + req.http.host + LF +
            "ip=" + req.http.Fastly-Client-IP + LF +
            "ts=" + now.sec + LF +
            "visit_scheme=" + if(fastly_info.edge.is_tls, "https", "http") + LF +
            "uag=" + req.http.user-agent + LF +
            "colo=" + server.datacenter + LF +
            "http=" + "http" + if(fastly_info.is_h3, "/3", if(fastly_info.is_h2, "/2", "/1.1")) + LF +
            "loc=" + client.geo.country_code + LF +
            "tls=" + tls.client.protocol;
  return(deliver);
}

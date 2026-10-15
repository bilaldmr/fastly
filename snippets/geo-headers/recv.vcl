# Forward client geo data to origin. cf-* headers keep Cloudflare-era origins working.
# Requires true-client-ip (runs before this) so geo is correct behind a shield.
set req.http.x-city = client.geo.city;
set req.http.x-country-code = client.geo.country_code;
set req.http.x-continent = client.geo.continent_code;
set req.http.x-longitude = client.geo.longitude;
set req.http.x-latitude = client.geo.latitude;
set req.http.x-region = client.geo.region;
set req.http.x-postal-code = client.geo.postal_code;
set req.http.x-timezone = client.geo.utc_offset;
set req.http.cf-ipcity = client.geo.city;
set req.http.cf-ipcountry = client.geo.country_code;
set req.http.cf-ipcontinent = client.geo.continent_code;
set req.http.cf-iplongitude = client.geo.longitude;
set req.http.cf-iplatitude = client.geo.latitude;
set req.http.cf-region = client.geo.region;
set req.http.cf-postal-code = client.geo.postal_code;
set req.http.cf-timezone = client.geo.utc_offset;

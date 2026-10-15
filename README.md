# Fastly VCL snippets

Reusable VCL snippets. One folder per feature; the file name is the snippet type
(`recv`, `miss`, `fetch`, `error`, `deliver`, `init`).

`miss.vcl` files marked "Also add as a pass snippet" go in both `vcl_miss` and `vcl_pass`.

| Snippet | What it does |
|---|---|
| true-client-ip | Keep real client IP through shielding, use it for geo (needed by geo-headers) |
| geo-headers | Send client geo to origin as `x-*` and `cf-*` headers |
| cors-fonts | `Access-Control-Allow-Origin: *` for woff/woff2 fonts |
| origin-debug-headers | Record origin status, move origin `x-cache` to `x-cache-origin` |
| custom-redirects | Table-driven redirects with host, path and wildcard keys |
| query-normalization | Strip tracking params + sort query for the cache key, origin gets original URL |
| cdn-cgi-image | Cloudflare `/cdn-cgi/image/...` URLs -> Fastly Image Optimizer |
| cdn-cgi-trace | Cloudflare-style `/cdn-cgi/trace` debug endpoint |
| drupal | Drupal/Acquia cookie, batch, `sites/files` and login-path rules |

`drupal` sets `var.is_pass = true;`, so it needs this at the top of `vcl_recv` (custom VCL),
plus `if (var.is_pass) { return(pass); }` before `return(lookup)`:

```vcl
declare local var.is_pass BOOL = false;
```

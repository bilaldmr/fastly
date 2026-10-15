# Value format: "<status>|<keep|drop query string>|<path or absolute https:// URL>"
# Keys: "/path", "host/path", or wildcard prefixes ending in "*" ("/old/*").
table redirects {
  "/example": "301|keep|/example/",
}

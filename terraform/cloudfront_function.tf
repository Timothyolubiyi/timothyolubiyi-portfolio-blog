resource "aws_cloudfront_function" "url_rewrite" {
  name    = "${local.project}-url-rewrite"
  runtime = "cloudfront-js-2.0"
  publish = true
  code    = <<-EOT
    async function handler(event) {
      var request = event.request;
      var uri = request.uri;

      // If URI ends with / serve index.html
      if (uri.endsWith('/')) {
        request.uri += 'index.html';
      }
      // If URI has no extension, append .html
      else if (!uri.includes('.')) {
        request.uri += '.html';
      }

      return request;
    }
  EOT
}
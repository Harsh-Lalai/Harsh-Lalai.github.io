source "https://rubygems.org"

# Local dev uses Jekyll 4 because Ruby 3.2+ removed String#tainted?,
# which breaks the Liquid version pinned by the `github-pages` gem.
# GitHub Pages still builds the deployed site with its own Jekyll 3.9.
# Keep templates limited to standard Jekyll features for compatibility.
gem "jekyll", "~> 4.3"

# Local web server
gem "webrick", "~> 1.8"

# Ruby 3.4+ removed these from default gems; some Jekyll deps still need them
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"
gem "ostruct"

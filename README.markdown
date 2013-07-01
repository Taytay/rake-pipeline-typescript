# Rake::Pipeline::Typescript

This is a typescript filter to compile Tyescript files in the Rake Pipeline.
Probably not ready for production. It appears to be quite slow, and my hunch is
that it's due to spawning a separate Node process for each file that needs to be
compiled. However, [typescript-rails](https://github.com/klaustopher/typescript-rails) is
using the typescript-node-ruby library as well without complaint, so maybe
the TS compiler is slow. I'm publishing it anyway. Please feel free to send pull
requests.

(I shamelessly forked [rake-pipeline-web-filters](https://github.com/wycats/rake-pipeline-web-filters)
since this is my first Gem)

Here's how you'd use it in your Assetfile:

```ruby
# Assetfile
require 'rake-pipeline-typescript'

#Other stuff up here (CoffeeScript, etc)

match "**/*.ts" do
  type_script
end

#More stuff down here...

```

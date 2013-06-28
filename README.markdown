# Rake::Pipeline::Typescript

This is a typescript filter to compile Tyescript files in the Rake Pipeline.

(I shamelessly forked [rake-pipeline-web-filters](https://github.com/wycats/rake-pipeline-web-filters) since this is my first Gem)

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

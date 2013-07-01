# Rake::Pipeline::Typescript

This is a typescript filter to compile Tyescript files in the Rake Pipeline.
Not ready for production. It's crazy slow, likely due to spawning a separate
Node process for each file that needs to be compiled. I cobbled together
something quickly and later realized I should probably have invoked the
Typescript compiler through a JS interpreter instead of forking to Node to do
it. I'm publishing it anyway. Please feel free to send a pull request to make
this usable. ;)

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

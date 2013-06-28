require "rake-pipeline"

module Rake
  class Pipeline
    module Typescript
    end
  end
end

require "rake-pipeline-typescript/version"
require "rake-pipeline-typescript/filter_with_dependencies"
require "rake-pipeline-typescript/type_script_filter"

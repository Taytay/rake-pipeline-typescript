module Rake::Pipeline::Typescript
  # Extends the Rake::Pipeline DSL to include shortcuts
  # for adding filters to the pipeline.
  #
  # You can do:
  #   !!!ruby
  #   match("*.ts") do
  #     type_script
  #   end
  module PipelineHelpers
    # Add a new {TypeScriptFilter} to the pipeline.
    # @see TypeScriptFilter#initialize
    def type_script(*args, &block)
      filter(Rake::Pipeline::Typescript::TypeScriptFilter, *args, &block)
    end
  end
end

require "rake-pipeline/dsl"

Rake::Pipeline::DSL::PipelineDSL.send(:include, Rake::Pipeline::Typescript::PipelineHelpers)

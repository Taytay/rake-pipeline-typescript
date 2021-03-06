require "execjs"

module Rake::Pipeline::Typescript
  # A filter that compiles TypeScript to JavaScript.
  class TypeScriptFilter < Rake::Pipeline::Filter
    include Rake::Pipeline::Typescript::FilterWithDependencies

    # @return [Hash] a hash of options to pass to CoffeeScript when
    #   rendering.
    attr_reader :options

    # By default, the CoffeeScriptFilter converts inputs
    # with the extension +.coffee+ to +.js+.
    #
    # @param [Hash] options options to pass to the CoffeeScript
    #   compiler.
    # @param [Proc] block the output name generator block
    def initialize(options = [], &block)
      block ||= proc { |input| input.sub(/\.ts$/, '.js') }
      super(&block)
      @options = options
    end

    # The body of the filter. Compile each input file into
    # a CoffeeScript compiled output file.
    #
    # @param [Array] inputs an Array of FileWrapper objects.
    # @param [FileWrapper] output a FileWrapper object
    def generate_output(inputs, output)
      inputs.each do |input|
        begin
          raise error ("I need a file to compile") if not input.respond_to?(:read)

          #puts "tsc: #{input.path} " << options.join(" ")

          #Using compile_file because it gives us better error messages
          result = TypeScript::Node::compile_file(input.fullpath, options)
          if result.success?
              output.write(result.js)
          else
            raise result.stderr
          end
        rescue ExecJS::Error => error
          raise error, "Error compiling #{input.path}. #{error.message}"
        rescue RuntimeError => e
          raise e, "Error compiling #{input.path}. #{e.message}"
        end
      end
    end

    def external_dependencies
      [ "typescript-node" ]
    end
  end
end

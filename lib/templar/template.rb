module Templar
  class Template
    def initialize(options)
      raise "Invalid options" unless validate_options(options)
      @output_dir = options.output_dir
      @template_dir = options.template_dir
      @template = Dir.new(File.join(options.template_dir.path, options.template))
    end

    def validate_options(options)
      options.respond_to?(:output_dir) && 
        options.respond_to?(:template) && 
        options.respond_to?(:template_dir)
    end

    def apply
      FileUtils.cp_r(@template, @output_dir)
    end
  end
end


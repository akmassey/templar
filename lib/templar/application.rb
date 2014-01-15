module Templar
  class Application
    attr_reader :template_dir

    def initialize(templates)
      if templates.nil?
        @template_dir = TemplateVars.new.default_template_dir
      else
        @template_dir = Dir.new templates
      end
    end

    def templates
      @template_dir.entries.reject do |d|
        d if [".", ".."].include?(d)
      end
    end

  end
end

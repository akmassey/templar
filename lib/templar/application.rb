module Templar
  class Application
    attr_reader :template_dir

    def initialize(templates)
      @template_dir = Dir.new templates
    end

    def templates
      @template_dir.each { |d| puts "#{d}" if File.directory?(d) }
    end
  end
end

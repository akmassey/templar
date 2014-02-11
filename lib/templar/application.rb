require 'ostruct'

module Templar
  class Application
    attr_reader :name

    def initialize(templates)
      options.ouput_dir = Dir.pwd
      options.template_dir = TemplateVars.new.default_template_dir
    end

    def templates
      options.template_dir.entries.reject do |d|
        d if [".", ".."].include?(d)
      end
    end

    def run
      init
      setup_template
    end

    def setup_template
      puts "would've set it up here: #{options.output_dir.path} using the #{options.template} template from #{options.template_dir.path}"
    end

    # Initialize the command line parameters and app name.
    def init(app_name='templar')
      standard_exception_handling do
        @name = app_name
        handle_options
        handle_arguments
      end
    end

    # Read and handle the command line options.
    def handle_options
      options.trace_output = $stderr

      OptionParser.new do |opts|
        opts.banner = "#{@name}: a LaTeX template manager"
        opts.define_head "Usage: templar [options] <filename>"
        opts.separator ""
        opts.separator "Examples:"
        opts.separator " templar --templates '../template_dir' new-project"
        opts.separator ""
        opts.separator "Options:"

        opts.on_tail("-h", "--help", "Display this help message") do
          puts opts
          exit
        end

        opts.on("-t", "--templates [DIR]", "Set templates directory. (Default: #{Templar::TemplateVars.new.default_template_dir.path})") do |dir|
          options.template_dir = Dir.open(dir)
        end

        opts.on("-d", "--directory [DIR]", "Set output directory") do |dir|
          options.output_dir = Dir.open(dir)
        end

        opts.on_tail("-v", "--version", "Show version") do
          puts Templar::VERSION
          exit
        end

      end.parse!
    end

    # Provide standard exception handling for the given block.
    def standard_exception_handling
      yield
    rescue SystemExit
      # Exit silently with current status
      raise
    rescue OptionParser::InvalidOption => ex
      $stderr.puts ex.message
      exit(false)
    rescue Exception => ex
      # Exit with error message
      display_error_message(ex)
      exit_because_of_exception(ex)
    end

    # Exit the program because of an unhandle exception.
    # (may be overridden by subclasses)
    def exit_because_of_exception(ex)
      exit(false)
    end

    def trace(*strings)
      options.trace_output ||= $stderr
      strings.each do |s|
        options.trace_output.print(s)
      end
      #trace_on(options.trace_output, *strings)
    end

    # Application options from the command line
    def options
      @options ||= OpenStruct.new
    end

    # Display the error message that caused the exception.
    def display_error_message(ex)
      trace "#{name} aborted!"
      trace ex.message
      # if options.backtrace
        # trace ex.backtrace.join("\n")
      # else
        # trace Backtrace.collapse(ex.backtrace).join("\n")
      # end
      # trace "Tasks: #{ex.chain}" if has_chain?(ex)
      # trace "(See full trace by running task with --trace)" unless
        # options.backtrace
    end

    def handle_arguments
      options.template = ARGV.shift.to_s.strip
      unless templates.include?(options.template)
        raise "Invalid template."
      end
    end

  end
end

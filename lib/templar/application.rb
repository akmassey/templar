require 'optparse'
require 'ostruct'
require 'safe_yaml'

module Templar

  class Application
    attr_reader :name

    def initialize
      options.config = Templar::Setup.new
    end

    def templates
      options.config.template_dir.entries.reject do |d|
        d if [".", ".."].include?(d)
      end
    end

    def run
      init
      setup_template
    end

    def setup_template
      template = Template.new options
      template.apply
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
        opts.define_head "Usage: templar [options] <project name>"
        opts.separator ""
        opts.separator "Examples:"
        opts.separator " templar -t article sample"
        opts.separator ""
        opts.separator "Options:"

        opts.on_tail("-h", "--help", "Display this help message") do
          puts opts
          exit
        end

        opts.on("-c", "--configuration [CONFIG]", "Specify a Templar Configuration file. (Default: #{options.config.conf_file})") do |conf|
          options.config.load(conf)
        end

        opts.on("-t", "--template [NAME]", "Choose a template to use. (Default: #{options.config.template})") do |t|
          if templates.include?(t)
            options.config.template = t
          else
            raise "Invalid template."
          end
        end

        opts.on("-d", "--directory [DIR]", "Set templates directory. (Default: #{options.config.template_dir.path})") do |dir|
          options.config.template_dir = Dir.open(dir)
        end

        opts.on("-o", "--output [DIR]", "Set output directory. (Default: #{options.config.output_dir.path})") do |dir|
          options.config.output_dir = Dir.open(dir)
        end

        opts.on("-l", "--list-templates", "List available templates.") do
          puts "#{templates}"
          exit
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
      trace "#{name} aborted!\n"
      trace ex.message + "\n"
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
      options.config.project_name = ARGV.shift.to_s.strip
    end

  end
end

require 'erb'

module Templar
  class Template
    def initialize(options)
      validate_options(options)

      # TODO: need a way to set these up so that non-required attributes are
      # still loaded as instance variables for erb to process them
      @output_dir = options.config.output_dir
      @template_dir = options.config.template_dir
      @template = options.config.template
      @author = options.config.author
      @first_name = options.config.first_name
      @last_name = options.config.last_name
      @webpage = options.config.webpage
      @biography = options.config.biography
      @affiliation = options.config.affiliation
      @department = options.config.department
      @institution = options.config.institution
      @city = options.config.city
      @location = options.config.location
      @email = options.config.email
      @title = options.config.project_title
      @project = options.config.project_name
      @month = Date.today.strftime("%B")
      @year = Date.today.year
    end

    # TODO: This doesn't validate first_name, last_name, or webpage
    def validate_options(options)
      raise "Invalid output directory." unless options.config.respond_to?(:output_dir)
      raise "Invalid template." unless options.config.respond_to?(:template)
      raise "Invalid template directory." unless options.config.respond_to?(:template_dir)
      raise "Invalid author." unless options.config.respond_to?(:author)
      raise "Invalid affiliation." unless options.config.respond_to?(:affiliation)
      raise "Invalid department." unless options.config.respond_to?(:department)
      raise "Invalid email." unless options.config.respond_to?(:email)
      raise "Invalid project name." unless options.config.respond_to?(:project_name)
      raise "Invalid project title." unless options.config.respond_to?(:project_title)
    end

    def apply
      apply_directory(File.join(@template_dir.path, @template))
    end

    # Copies a file or processes an erb template
    def apply_file(file, output_dir)
      # TODO: this should refer to the project_config_file variable from
      # Templar::Setup.
      return if File.basename(file) == "templar.yaml"

      if file.match(/\.erb$/)
        out = File.join(output_dir, File.basename(file, ".erb").gsub(@template, @project))
        erb = ERB.new(File.read(file))
        File.open(out, 'w') do |f|
          begin
            f.write erb.result(binding)
          rescue
            puts "Unable to process file: #{file}"
            exit
          end
        end
      else
        out = File.join(output_dir, File.basename(file).gsub(@template, @project))
        File.open(out, 'w') do |f|
          f.write File.read(file)
        end
      end
    end

    # Recursively copies directories and files into the output location
    def apply_directory(dir)
      output_base = dir.gsub(@template_dir.path, "").gsub(@template, @project)
      output_dir = File.join(@output_dir.path, output_base)
      FileUtils.mkdir_p(output_dir)

      dir = Dir.new(dir)
      files = dir.entries.reject do |d|
        /^(\.|\.\.)$/.match(d)
      end

      # get full path for all files that need to be copied
      files.map! do |file|
        File.join(dir, file)
      end

      dirs = files.select do |file|
        File.directory?(file)
      end

      files.reject! do |file|
        File.directory?(file)
      end

      files.each do |file|
        apply_file(file, output_dir)
      end

      dirs.each do |d|
        apply_directory d
      end
    end
  end
end


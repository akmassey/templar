require 'safe_yaml'

module Templar

  # TODO: Templar::Setup should be configuration for system-wide stuff.  So
  # probably only template_dir and output_dir.
  class Setup
    attr_reader :config, :conf_file
    def initialize
      @config = { author: "John Purdue",
                  affiliation: "Purdue University",
                  department: "Department of Computer Science",
                  email: "jpurdue1@purdue.edu",
                  template_dir: Dir.new(File.join(Dir.home, ".templar")),
                  template: "article",
                  output_dir: Dir.new(Dir.pwd),
                  project_title: "Go Boilers!",
                  project_name: "article",
                  project_config_file: "templar.yaml"
      }

      # required variables
      @conf_file = File.join(Dir.home, ".templar_config.yaml")

      reset_config(@config)
      load(@conf_file)
      project_config_file = File.join(@config[:template_dir],
                               @config[:template],
                               @config[:project_config_file])
      if File.exist?(project_config_file) and not File.directory?(project_config_file)
        load_project_config(YAML.load(File.read(project_config_file)))
      end
    end

    def load(filename)
      load_yaml(filename)
    end

    def load_yaml(filename)
      yaml = File.read(filename)
      @conf_file = filename
      reset_config(YAML.load(yaml))
    end

    def reset_config(hash)
      hash.each do |k,v|
        instance_variable_set("@#{k}",v)

        # set accessor
        eigenclass = class<<self; self; end
        eigenclass.class_eval do
          attr_accessor k
        end
      end
    end

    def load_project_config(hash)
      p hash
      hash.each do |key, value|
        if key == "default_variables"
          value.each do |k, v|
            instance_variable_set("@#{k}",v)

            # set accessor
            eigenclass = class<<self; self; end
            eigenclass.class_eval do
              attr_accessor k
            end
          end
        elsif key =="prompt_for"
          value.each do |var|
            response = prompt_for_variable(var)
            instance_variable_set("@#{var}", response)

            eigenclass = class<<self; self end
            eigenclass.class_eval do
              attr_accessor var
            end
          end
        end
      end
    end

    def prompt_for_variable(var)
      print "Please enter a #{var}: "
      retval = STDIN.gets.chomp
      return retval
    end
  end
end

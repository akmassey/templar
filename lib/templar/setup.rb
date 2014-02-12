require 'safe_yaml'

module Templar
  class Setup
    attr_reader :config, :conf_file
    def initialize
      @config = { author: "John Purdue",
                  affiliation: "Purdue University",
                  department: "Department of Computer Science",
                  email: "jpurdue1@purdue.edu",
                  template_dir: Dir.new(File.join(Dir.home, ".templar")),
                  template: "article",
                  output_dir: Dir.pwd,
                  project_title: "Awesome Document",
                  project_name: "article"
      }

      # required variables
      @conf_file = File.join(Dir.home, ".templar_config.yaml")

      reset_config(@config)
      load(@conf_file)
    end

    def load(filename)
      load_yaml(filename)
      p @config
    end

    def load_yaml(filename)
      yaml = File.read(filename)
      @conf_file = filename
      reset_config(YAML.load(yaml, safe: true))
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

  end
end

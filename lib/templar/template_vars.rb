# a set of configuration variable to be used in an erb template
module Templar
  class TemplateVars
    attr_reader :first_name, :last_name, :email, :default_template_dir
    def initialize
      # required variables
      @first_name = "John"
      @last_name = "Purdue"
      @email = "jpurdue1@purdue.edu"
      @default_template_dir = Dir.new "#{Dir.home}/.templar"
    end
  end
end

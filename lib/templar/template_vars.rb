# a set of configuration variable to be used in an erb template
module Templar
  class TemplateVars
    attr_reader :first_name, :last_name, :email
    def initialize
      # required variables
      @first_name = "John"
      @last_name = "Purdue"
      @email = "jpurdue1@purdue.edu"
    end
  end
end

require "spec_helper"

module Templar
  describe TemplateVars do
    it "should have a first name" do
      c = TemplateVars.new
      c.first_name.should_not be nil
    end

    it "should have a last name" do
      c = TemplateVars.new
      c.last_name.should_not be nil
    end

    it "should have an email" do
      c = TemplateVars.new
      c.email.should_not be nil
    end
  end
end


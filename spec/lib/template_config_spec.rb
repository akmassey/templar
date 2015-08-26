require "spec_helper"

module Templar
  describe TemplateConfig do
    it "should have a first name" do
      c = TemplateConfig.new(nil)
      expect(c.first_name).to be nil
    end

    it "should have a last name" do
      c = TemplateConfig.new(nil)
      expect(c.last_name).to be nil
    end

    it "should have an email" do
      c = TemplateConfig.new(nil)
      expect(c.email).to be nil
    end
  end
end


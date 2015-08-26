require 'spec_helper'

module Templar
  describe "Version" do
    it "should have a version" do
      expect(VERSION).to_not be nil
    end
  end
end

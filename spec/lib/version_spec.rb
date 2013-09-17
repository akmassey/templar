require 'spec_helper'

module Templar
  describe "Version" do
    it "should have a version" do
      VERSION.should_not be nil
    end
  end
end

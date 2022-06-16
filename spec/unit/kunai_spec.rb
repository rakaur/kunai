require_relative "../spec_helper"

describe Kunai do
  subject { Kunai }

  describe "VERSION" do
    it "is the correct version" do
      _(subject::VERSION).must_equal "0.1.0"
    end
  end

  describe "env" do
    it "returns the correct environment" do
      _(subject.env).must_equal :test
    end
  end

  describe "initialize!" do
    it "exists" do
      _(subject).must_respond_to :initialize!
    end

    it "returns true" do
      subject.stub(:puts, nil) do
         actual = subject.initialize!(:test)
         _(actual).must_be_instance_of TrueClass
      end
    end
  end
end

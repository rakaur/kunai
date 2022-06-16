require_relative "../spec_helper"

describe Kunai do
  subject { Kunai }

  describe "VERSION" do
    it "is the correct version" do
      _(subject::VERSION).must_equal "0.1.0"
    end
  end

  describe "env" do
    it "returns the correct environment upon initialization" do
      subject.stub(:puts, nil) do
        subject.initialize!(env: :test)
        _(subject.env).must_equal :test
      end
    end
  end

  describe "initialize!" do
    it "returns true when no errors" do
      subject.stub(:puts, nil) do
        _(subject.initialize!(env: :test, config: "config/ircd.yml")).must_equal true
      end
    end
    it "raises when errors" do
      subject.stub(:puts, nil) do
        options = { env: :test, config: "spec/fixtures/bad_ircd.yml" }
        _ { subject.initialize!(options) }.must_raise StandardError
      end
    end
  end
end

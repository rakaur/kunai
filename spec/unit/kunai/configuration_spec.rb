require_relative "../../spec_helper"

module Kunai
  describe Configuration do
    subject { Configuration.new }

    it "returns nil on bad key" do
      _(subject.garbage).must_be_nil
    end

    it "raises on bad bang key" do
      _ { subject.garbage! }.must_raise KeyError
    end

    it "has a String representation" do
      _(subject.inspect).must_equal "#<#{subject.class.name} {}>"
    end
  end

  describe Configuration do
    subject { Configuration.new(YAML.load_file("spec/fixtures/good_ircd.yml")) }

    it "has the correct listeners" do
      _(subject.listen.present?).must_equal true
      _(subject.listen).must_equal [{ host: "127.0.0.1",
                                      port: 6667 },
                                    { host: "0.0.0.0",
                                      port: 6969 }]
    end
    it "raises an error" do
      _ { Configuration.new(YAML.load_file("spec/fixtures/bad_ircd.yml")) }.must_raise StandardError
    end
  end
end

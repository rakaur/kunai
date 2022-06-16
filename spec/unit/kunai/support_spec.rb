require_relative "../../spec_helper"

describe Object do
  subject { Object.new }

  it "isn't blank" do
    _(subject.blank?).must_equal false
  end
  it "is present" do
    _(subject.present?).must_equal true
  end
  it "has presence" do
    _(subject.presence).must_equal subject
  end
end

describe NilClass do
  subject { nil }

  it "is blank" do
    _(subject.blank?).must_equal true
  end
  it "isn't present" do
    _(subject.present?).must_equal false
  end
  it "has no presence" do
    _(subject.presence).must_be_nil nil
  end
end

describe FalseClass do
  subject { false }

  it "is blank" do
    _(subject.blank?).must_equal true
  end
  it "isn't present" do
    _(subject.present?).must_equal false
  end
  it "has no presence" do
    _(subject.presence).must_be_nil nil
  end
end

describe TrueClass do
  subject { true }

  it "isn't blank" do
    _(subject.blank?).must_equal false
  end
  it "is present" do
    _(subject.present?).must_equal true
  end
  it "has presence" do
    _(subject.presence).must_equal subject
  end
end

describe "Array" do
  describe "empty Array" do
    subject { [] }

    it "is blank" do
      _(subject.blank?).must_equal true
    end
    it "isn't present" do
      _(subject.present?).must_equal false
    end
    it "has no presence" do
      _(subject.presence).must_be_nil
    end
  end

  describe "not empty Array" do
    subject { [1, 2, 3] }

    it "isn't blank" do
      _(subject.blank?).must_equal false
    end
    it "is present" do
      _(subject.present?).must_equal true
    end
    it "has presence" do
      _(subject.presence).must_equal subject
    end
  end
end

describe "Hash" do
  describe "empty Hash" do
    subject { {} }

    it "is blank" do
      _(subject.blank?).must_equal true
    end
    it "isn't present" do
      _(subject.present?).must_equal false
    end
    it "has no presence" do
      _(subject.presence).must_be_nil
    end
  end

  describe "not empty Hash" do
    subject { { a: :a, b: :b, c: :c } }

    it "isn't blank" do
      _(subject.blank?).must_equal false
    end
    it "is present" do
      _(subject.present?).must_equal true
    end
    it "has presence" do
      _(subject.presence).must_equal subject
    end
  end
end

describe "String" do
  describe "empty String" do
    subject { "" }

    it "is blank" do
      _(subject.blank?).must_equal true
    end
    it "isn't present" do
      _(subject.present?).must_equal false
    end
    it "has no presence" do
      _(subject.presence).must_be_nil
    end
  end

  describe "not empty String" do
    subject { "Mountain Dew is the worst soda ever made" }

    it "isn't blank" do
      _(subject.blank?).must_equal false
    end
    it "is present" do
      _(subject.present?).must_equal true
    end
    it "has presence" do
      _(subject.presence).must_equal subject
    end
  end
end

describe Numeric do
  subject { 1 }

  it "isn't blank" do
    _(subject.blank?).must_equal false
  end
  it "is present" do
    _(subject.present?).must_equal true
  end
  it "has presence" do
    _(subject.presence).must_equal subject
  end
end

describe Time do
  subject { Time.now }

  it "isn't blank" do
    _(subject.blank?).must_equal false
  end
  it "is present" do
    _(subject.present?).must_equal true
  end
  it "has presence" do
    _(subject.presence).must_equal subject
  end
end

require_relative "../../spec_helper"

module Kunai
  describe Client do
    subject { Client.new Minitest::Mock.new }

    describe "need_write?" do
      it "doesn't need write" do
        _(subject.need_write?).must_equal false
      end
      it "needs write" do
        _(subject.need_write?).must_equal false
        subject.write("test")
        _(subject.need_write?).must_equal true
      end
    end

    describe "flush" do
      it "flushes" do
        mock = Minitest::Mock.new
        def mock.write_nonblock(*args); true; end
        subject = Client.new(mock)

        subject.write("test")

        subject.flush
      end
    end

    describe "read" do
      it "reads" do
        mock = Minitest::Mock.new
        def mock.read_nonblock(*args); "line\r\n"; end
        subject = Client.new(mock)

        subject.read
      end
      it "doesn't read" do
        mock = Minitest::Mock.new
        def mock.read_nonblock(*args); nil; end
        subject = Client.new(mock)

        subject.read
      end
    end
  end
end

require 'spec_helper'
require 'wordwrap'

describe Wordwrap do
  describe "#initialize" do
    it "instantiates" do
      expect {
        Wordwrap.new(4)
      }.to_not raise_exception
    end

    it "raises on empty arguments" do
      expect {
        Wordwrap.new
      }.to raise_exception
    end

    it "raises on non-numeric argument" do
      expect {
        Wordwrap.new "foo"
      }.to raise_exception
    end
  end

  describe "#wrap" do
    subject { Wordwrap.new(4) }

    it "accepts string" do
      expect {
        subject.wrap("this is a text")
      }.to_not raise_exception
    end


    it "raises for non-string parameters" do
      expect { subject.wrap([1,2,3]) }.to raise_exception
    end

    it "wraps empty string" do
      subject.wrap("").should == ""
    end

    it "returns one short word as-is" do
      Wordwrap.new(6).wrap('word').should == 'word'
    end

    describe "wraps at the last space before wrap length" do
      specify do
        Wordwrap.new(5).wrap("word word").should == "word\nword"
      end

      specify do
        Wordwrap.new(5).wrap("word word word").should == "word\nword\nword"
      end

      specify do
        Wordwrap.new(10).wrap("word word word").should ==  "word word\nword"
      end
    end

    specify "Long words without spaces should be broken at the wrap length" do
      Wordwrap.new(4).wrap("wordword").should == "word\nword"
    end

    specify "Strings with long words and spaces should mix breaking words and at spaces" do
      Wordwrap.new(3).wrap("word word word").should == "wor\nd\nwor\nd\nwor\nd"
    end

  end
end

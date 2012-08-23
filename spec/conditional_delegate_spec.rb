require 'spec_helper'

class Parent
  attr_accessor :foo, :bar, :baz, :qux
end

class Child
  extend ConditionalDelegate

  attr_accessor :parent, :foo, :bar, :baz, :qux

  conditional_delegate :foo, to: :parent, if: :empty?
  conditional_delegate :bar, to: :parent, if: lambda { |value| value == "something" }

  conditional_delegate :baz, :qux, to: :parent, if: :empty?
end

describe ConditionalDelegate do

  context "delegation" do

    it "should delegate if condition is met" do
      parent = Parent.new
      parent.foo = "parent foo"

      child = Child.new
      child.parent = parent
      child.foo = ""

      child.foo.should == "parent foo"
    end

    it "should not delegate if condition is not met" do
      parent = Parent.new
      parent.foo = "parent foo"

      child = Child.new
      child.parent = parent
      child.foo = "child foo"

      child.foo.should == "child foo"
    end

    it "should delegate multiple fields if condition is met" do
      parent = Parent.new
      parent.baz = "parent baz"
      parent.qux = "parent qux"

      child = Child.new
      child.parent = parent
      child.baz = "child baz"
      child.qux = ""

      child.baz.should == "child baz"
      child.qux.should == "parent qux"
    end

  end

  context "raising errors" do

    it "should raise an error if the delegate is nil" do
      child = Child.new
      child.foo = ""

      lambda { child.foo }.should raise_error(NoMethodError)
    end

    it "should not raise an error if the delegate is not nil" do
      parent = Parent.new
      parent.foo = "bar"

      child = Child.new
      child.parent = parent
      child.foo = "foo"

      lambda { child.foo }.should_not raise_error(NoMethodError)
    end

  end

  context "lambda condition" do

    it "should delegate if lambda condition is met" do
      parent = Parent.new
      parent.bar = "qux"

      child = Child.new
      child.parent = parent
      child.bar = "something"

      child.bar.should == "qux"
    end

    it "should not delegate if lambda condition is not met" do
      parent = Parent.new
      parent.bar = "qux"

      child = Child.new
      child.parent = parent
      child.bar = "something else"

      child.bar.should == "something else"
    end

  end

end

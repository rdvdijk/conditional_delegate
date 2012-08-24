# ConditionalDelegate
[![Build Status](https://secure.travis-ci.org/rdvdijk/conditional_delegate.png)](http://travis-ci.org/rdvdijk/conditional_delegate)

**ConditionalDelegate** allows delegates to be conditional.

## Installation

Add this line to your application's Gemfile:

    gem 'conditional_delegate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install conditional_delegate

## Usage

Here is a short example with a parent and child class. Calls
to the child object are delegated to its parent if the
condition for that delegation is met.

Simple parent class with four accessors:

```ruby
class Parent
  attr_accessor :foo, :bar, :baz, :qux
end
```

Child class with the same accessors as the parent, and some
conditional delegates defined:

```ruby
class Child
  extend ConditionalDelegate

  attr_accessor :parent, :foo, :bar, :baz, :qux

  conditional_delegate :foo, to: :parent, if: :empty?
  conditional_delegate :bar, to: :parent, if: lambda { |value| value == "something" }

  conditional_delegate :baz, :qux, to: :parent, if: :empty?
end
```

The field `foo` is delegated to the parent if the value of `foo` in the child is `empty?`.

The field `bar` is delegated to the parent if the given lambda returns true for the child's `foo` value.

Both the fields `baz` and `qux` are delegated to the parent if the child's field values are `empty?`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

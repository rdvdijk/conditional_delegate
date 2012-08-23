require "conditional_delegate/version"

module ConditionalDelegate

  def conditional_delegate(*attributes, options)
    attributes.each do |attribute|
      module_eval do
        define_delegate_method(attribute, options)
      end
    end
  end

  private

  def define_delegate_method(attribute, options)
    own_method = :"_#{attribute}"
    alias_method own_method, :"#{attribute}"

    define_method :"#{attribute}" do
      value = send own_method
      condition = options[:if]

      if condition.is_a? Proc and condition.call(value)
        send(options[:to]).send(attribute)
      elsif condition.is_a? Symbol and value.send(condition)
        send(options[:to]).send(attribute)
      else
        value
      end
    end
  end

end

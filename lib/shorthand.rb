module Shorthand

  def self.included(target_class)
    target_class.instance_eval do
      include Init
      include Method
    end
  end

  module Init
    def initialize(*args, &block)
      super
      if block
        ::Shorthand::Provider.new(self, &block)
      end
    end
  end

  module Method
    def shorthand(&block)
      if block
        ::Shorthand::Provider.new(self, &block)
      end
    end
  end
  
  class Provider
    def initialize(target, &block)
      @target = target
      if block.arity == 1
        yield self
      else
        instance_eval(&block)
      end
    end
    def method_missing(meth, *args, &block)
      if @target.respond_to?(message = "#{meth}=", true)
        @target.__send__(message, *args, &block)
      else
        super
      end
    end
  end

end

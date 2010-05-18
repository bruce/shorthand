require 'helper'

class TestShorthand < Test::Unit::TestCase

  context 'instances of classes including Shorthand' do
    setup do
      @klass = Class.new do
        include Shorthand
        attr_accessor :foo
      end
    end

    context "using the shorthand method" do
      subject do
        @klass.new
      end
      should 'have an method named shorthand' do
        assert subject.respond_to?(:shorthand)
      end
      context 'when calling the writer in shorthand with instance_eval semantics' do
        setup do
          subject.shorthand { foo 1 }
        end
        should_change 'assigned value', :from => nil, :to => 1 do
          subject.foo
        end
      end
      context 'when calling the writer in shorthand with yield semantics' do
        setup do
          subject.shorthand { |s| s.foo 1 }
        end
        should_change 'assigned value', :from => nil, :to => 1 do
          subject.foo
        end
      end
    end
    context "initializing with a block" do
      context 'with instance_eval semantics' do
        subject do
          @klass.new { foo 1 }
        end
        should 'set foo' do
          assert_equal 1, subject.foo
        end
      end
      context 'with yield semantics' do
        subject do
          @klass.new { |f| f.foo 1 }
        end
        should 'set foo' do
          assert_equal 1, subject.foo
        end
      end
    end

    private

    def shorthand(&block)
      subject.shorthand(&block)
    end

  end
end

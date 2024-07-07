module Minitestw
  class Test
    attr_reader :failures, :assertion_size

    def initialize
      @failures = []
      @assertion_size = 0
    end

    def assert(statement)
      @assertion_size += 1
      # TODO: Failure class
      unless statement
        @failures << Object.new
        raise "Assertion failed"
      end
    end

    def assert_equal(expected, actual)
      @assertion_size += 1
      unless expected == actual
        @failures << Object.new
        raise "Expected #{expected}, but got #{actual}"
      end
    end

    def self.inherited(subclass)
      subclass.class_eval do
        def self.method_added(name)
          @test_methods ||= []
          @test_methods << name if name.to_s.match(/^test_/)
          super
        end

        at_exit do
          instance = new
          instance.setup
          @test_methods.each do |test_method|
            instance.__send__(test_method)
          rescue => e
            puts "\n* Failure:"
            puts "#{subclass.name}##{test_method} [#{subclass.instance_method(test_method).source_location.join(':')}]"
            puts e.message
          end

          puts "\n#{@test_methods.size} runs, #{instance.assertion_size} assertions, #{instance.failures.size} failures"
        end
      end
    end
  end
end

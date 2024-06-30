module Minitestw
  class Test
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
          end
        end
      end
    end
  end
end

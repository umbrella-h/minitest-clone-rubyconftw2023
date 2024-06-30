module Minitestw
  class Test
    def self.inherited(subclass)
      subclass.class_eval do
        def self.method_added(name)
          # p self
          @test_methods ||= []
          @test_methods << name if name.to_s.match(/^test_/)
          super
        end

        at_exit do
          # p self # if forgeting `self.inherited`, the output will be 'Minitestw::Test' and `nil`
          p @test_methods
        end
      end
    end
  end
end

class HelloWorld
  class << self
    def hello
      standard_greeting
    end

    def hello(name = nil)
      name.nil? ? standard_greeting : personalized_greeting(name)
    end

    private

    def standard_greeting
      'Hello, World!'
    end

    def personalized_greeting(name)
      "Hello, #{name}!"
    end
  end
end

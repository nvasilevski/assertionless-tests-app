module Minitest
  class AssertionlessTestsReporter < Reporter
    def initialize(options = {})
      super()
      @assertless_tests = []
    end

    def record(result)
      super
      return if result.assertions.positive? || !result.passed?
      
      assertless_tests << result
    end

    def report
      return if assertless_tests.empty?
      sources_list = assertless_tests.map do |result|
        "#{result.name} at #{test_source_location(result)}"
      end.join("\n")

      io.print(<<~MSG)
        The following tests don't contain any assertions:
        #{sources_list}
      MSG
    end

    private

    attr_reader :assertless_tests

    def test_source_location(result)
      result.source_location.join(":")
    end
  end
end


module Minitest
  def self.plugin_assertionless_tests_init(options)
    self.reporter << AssertionlessTestsReporter.new(options)
  end
end

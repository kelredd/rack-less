require 'rack/test'
require 'webrat'

class Assert::Context
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat.configure do |config|
    config.mode = :rack
  end

  class << self

    def should_respond_with_compiled_css
      should "return compiled css" do
        assert_equal 200, @response.status, "status is not '#{Rack::Utils::HTTP_STATUS_CODES[200]}'"
        assert @response.headers["Content-Type"].include?(Rack::Less::MIME_TYPE), "content type is not '#{Rack::Less::MIME_TYPE}'"
        assert_equal @compiled.strip, @response.body.strip, "the compiled css is incorrect"
      end
    end

  end

end

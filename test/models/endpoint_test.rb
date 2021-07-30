require "test_helper"

class EndpointTest < ActiveSupport::TestCase

  def setup
    @endpoint = Endpoint.new(
      verb: "GET",
      path: "/greetings",
      response: {
        code: 200,
        headers: {"Content-Type": "application/json"},
        body: "\"{ \"message\": \"Hello, world\" }\""
      }
    )
  end

  test "valid endpoint" do
    assert @endpoint.valid?
  end

  test "valid endpoint with optional header and body attributes" do
    @endpoint.response.delete("headers")
    @endpoint.response.delete("body")
    assert @endpoint.valid?
  end

  test "invalid endpoint without verb" do
    @endpoint.verb = nil
    assert @endpoint.invalid?
  end

  test "invalid endpoint without path" do
    @endpoint.path = nil
    assert @endpoint.invalid?
  end

  test "invalid endpoint with invalid path url" do
    @endpoint.path = "/greeting{><welcome"
    assert @endpoint.invalid?
  end

  test "invalid endpoint without response" do
    @endpoint.response = nil
    assert @endpoint.invalid?
  end

  test "invalid endpoint without response code" do
    @endpoint.response.delete("code")
    assert @endpoint.invalid?
  end

  test "invalid endpoint with response code as string value" do
    @endpoint.response["code"] = "200"
    assert @endpoint.invalid?
  end

  test "invalid endpoint with invalid headers data" do
    @endpoint.response["headers"] = "set_headers"
    assert @endpoint.invalid?
  end

  test "path should be unique with verb" do
    @endpoint.save
    endpoint2 = Endpoint.create(verb: "POST", path: "/greetings", response: {code: 200})
    endpoint3 = Endpoint.create(verb: "GET", path: "/greetings", response: {code: 200})
    assert @endpoint.valid?
    assert endpoint2.valid?
    assert endpoint3.invalid?
  end
end

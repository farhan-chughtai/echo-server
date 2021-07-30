require "test_helper"

class EchosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint = Endpoint.create(
      verb: "GET",
      path: "/greetings",
      response: {
        code: 200,
        headers: {"Content-Type": "application/json"},
        body: "\"{ \"message\": \"Hello, world\" }\""
      }
    )
  end

  test "should return valid response if client requests correct existing path" do
    get "/greetings", as: :json
    assert_response @endpoint.response["code"]
    assert_equal response.body, "\"{ \"message\": \"Hello, world\" }\""
  end

  test "should return valid response with status_code of endpoint if client requests correct existing path" do
    @endpoint.response["code"] = 500
    @endpoint.save
    get "/greetings", as: :json
    assert_response @endpoint.response["code"]
    assert_equal response.body, "\"{ \"message\": \"Hello, world\" }\""
  end

  test "should return not_found if client requests non-existing path" do
    get "/hello", as: :json
    json_response = JSON.parse(response.body)
    assert_response :not_found
    assert_equal json_response["errors"]["code"], "not_found"
    assert_equal json_response["errors"]["detail"], "Requested page `/hello` does not exist"
  end

  test "should return not_found if client requests existing path with wrong verb" do
    post "/hello", as: :json
    json_response = JSON.parse(response.body)
    assert_response :not_found
    assert_equal json_response["errors"]["code"], "not_found"
    assert_equal json_response["errors"]["detail"], "Requested page `/hello` does not exist"
  end

end

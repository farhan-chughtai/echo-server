require "test_helper"

class EndpointsControllerTest < ActionDispatch::IntegrationTest
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

  test "should get index" do
    get endpoints_url, as: :json
    json_response = JSON.parse(response.body)
    assert_response :success
    assert_equal json_response["data"].count, 1
  end

  test "should create end_point" do
    assert_difference('Endpoint.count') do
      post endpoints_url, params: { data: { type: "endpoints", attributes: {path: "/welcome", response: {code: 200}, verb: "GET" } } }, as: :json
    end
    assert_response 201
  end

  test "should create end_point with same path but with different verb" do
    assert_difference('Endpoint.count') do
      post endpoints_url, params: { data: { type: "endpoints", attributes: {path: "/greetings", response: {code: 200}, verb: "POST" } } }, as: :json
    end
    assert_response 201
  end

  test "should not create end_point with same path and same verb" do
    post endpoints_url, params: { data: { type: "endpoints", attributes: {path: "/greetings", response: {code: 200}, verb: "GET" } } }, as: :json
    json_response = JSON.parse(response.body)
    assert_response :unprocessable_entity
    assert_equal json_response["errors"][0]["code"], "unprocessable_entity"
    assert_equal json_response["errors"][0]["detail"], "Path has already been taken"
    assert_equal Endpoint.count, 1
  end

  test "should show end_point" do
    get endpoint_url(@endpoint), as: :json
    assert_response :success
  end

  test "show end_point should return 404 not_found with wrong id " do
    get endpoint_url(123), as: :json
    assert_response :not_found
  end

  test "should update endpoint" do
    patch endpoint_url(@endpoint), params: { data: { type: "endpoints", attributes: {path: "/testing", response: @endpoint.response, verb: @endpoint.verb} } }, as: :json
    assert_response 200
  end

  test "should not update endpoint if path and verb already exists" do
    endpoint = Endpoint.create(
      verb: "POST",
      path: "/greetings",
      response: {
        code: 200
      }
    )
    patch endpoint_url(@endpoint), params: { data: { type: "endpoints", attributes: {path: @endpoint.path, response: @endpoint.response, verb: "POST"} } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy endpoint" do
    assert_difference('Endpoint.count', -1) do
      delete endpoint_url(@endpoint), as: :json
    end
    assert_response 204
  end

  test "should return not_found with wrong id to destroy endpoint" do
    delete endpoint_url(124), as: :json
    assert_response :not_found
  end
end

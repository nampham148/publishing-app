require 'test_helper'

class VoteRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get vote_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get vote_relationships_destroy_url
    assert_response :success
  end

end

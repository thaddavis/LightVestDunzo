require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,          "LightVest"
    assert_equal full_title("Help"),  "Help | LightVest"
  end
end

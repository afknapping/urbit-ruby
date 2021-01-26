require "test_helper"
require 'json'

class Urbit::MessageTest < Minitest::Test
  def setup
    @ship = Urbit::Api::Ship.new
    @c = Urbit::Api::Channel.new @ship, "Test Channel"
  end

  def test_Message_initialization
    m = Urbit::Api::Message.new @c, 1, "poke", "hood", "helm-hi", "Test Message"
    refute_nil m.id
  end

  def test_Message_can_serialize_itself_as_json
    m = Urbit::Api::Message.new @c, 1, "poke", "hood", "helm-hi", "Test Message"
    j = JSON.parse m.as_json
    assert_equal 1, j['id']
    assert_equal "zod", j['ship']
  end

  def test_Message_can_serialize_itself_as_a_json_string
    m = Urbit::Api::Message.new @c, 1, "poke", "hood", "helm-hi", "Opening airlock"
    assert_equal '{"id":1,"ship":"zod","action":"poke","app":"hood","mark":"helm-hi","json":"Opening airlock"}', m.as_json
  end
end

# curl --header "Content-Type: application/json"
#      --cookie "urbauth-~zod=0v3.okvjc.4segg.g1mh8.32pkn.silsv"
#      --request PUT
#       --data '[{"id":1,"action":"poke","ship":"zod","app":"hood","mark":"helm-hi","json":"Opening airlock"}]'
#   http://localhost:8080/~/channel/1601844290-ae45b
require "urbit/ship"

describe Urbit::Channel do
  let(:ship) { Urbit::Ship.new }
  let!(:channel) { ship.open_channel('Test Channel') }

  after(:each) do
    channel.close if channel.open?
  end

  it "is initialized with a name" do
    expect(channel.name).to_not be_nil
    expect(channel.name).to eq('Test Channel')
  end

  it "has an autogenerated key" do
    expect(channel.key).to_not be_nil
  end

  it "has a key 16 chars long" do
    expect(channel.key.size).to eq(16)
  end

  it "can send a message once opened" do
    expect(channel.sent_messages.size).to eq(1)
    expect(channel.open?)
  end

  it "can be closed" do
    expect(channel.sent_messages.size).to eq(1)
    expect(channel.open?)
    expect(channel.close)
    expect(channel.open?).to be false
    expect(channel.sent_messages.size).to eq(2)
    expect(channel.sent_messages.last.id).to eq(2)
  end

  it "can subscribe" do
    expect(channel.sent_messages.size).to eq(1)
    # expect(s = channel.subscribe).to_not be_nil

    # Subscribing sends a message to the ship
    # expect(channel.sent_messages.size).to eq(2)

    # Let's send a message to the channel?
    # m = Urbit::Api::Message.new channel, 3, "poke", "chat-view", "/primary", "Test Subscriber Message"
    # sleep(10)
  end

  it "can be represented as a string" do
    expect(channel.to_s).to eq("a Channel (Open) on ~zod(name: 'Test Channel', key: '#{channel.key}')")
  end

end

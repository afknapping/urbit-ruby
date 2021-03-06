require "urbit/ship"

describe Urbit::Ship do
  let(:instance) { described_class.new }

  it "has a pat p" do
    expect(instance.pat_p).to_not be_nil
    expect(instance.pat_p).to eq("~zod")
  end

  it "is not initially logged in" do
    expect(instance.logged_in?).to be false
  end

  it "can log in" do
    # NOTE: This test will fail if you don''t have a fake zod running.
    instance.login
    expect(instance.logged_in?)
    expect(instance.cookie).to_not be_nil
  end

   it "can open a channel" do
     c = instance.open_channel "Test Channel"
     expect(instance.open_channels.size).to eq(1)
    c.close
   end

  it "test opening the channel answers the new channel" do
    c = instance.open_channel "Test Channel"
    expect(c).to be_instance_of(Urbit::Channel)
    c.close
  end

  it "closing the channel makes it unavailable" do
    c = instance.open_channel "Test Channel"
    expect(instance.open_channels.size).to eq(1)
    c.close
    expect(instance.open_channels.size).to eq(0)
  end

  it "can be represented as a string" do
    expect(instance.to_s).to eq("a Ship(name: '~zod', host: 'http://localhost', port: '8080')")
  end

  #-------------------------------------------------------------------
  # This test is a tricky one and I couldn't get it to work.
  # You can, however, assure yourself that it is actually true by
  # uncommenting the "puts" in channel.close and you'll see it is
  # called when your program ends.
  #-------------------------------------------------------------------
  # it test_destroying_a_ship_closes_all_its_channels
  #   c = instance.open_channel "Test Channel"
  #   assert_equal 1, instance.open_channels.size
  #   assert c.open?
  #   instance = nil
  #   GC.start(full_mark: true, immediate_sweep: true)
  #   sleep 15
  #   assert c.closed?
  # end
end

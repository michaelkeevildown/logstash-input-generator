# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/inputs/generator"

describe LogStash::Inputs::Generator do

  it_behaves_like "an interruptible input plugin" do
    let(:config) { { "event_interval" => 1 } }
  end

end

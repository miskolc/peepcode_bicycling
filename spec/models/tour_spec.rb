require 'spec_helper'

describe Tour do
  it { subject.should respond_to(:name) }
end
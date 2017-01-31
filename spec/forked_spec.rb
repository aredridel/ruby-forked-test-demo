require 'spec_helper'

RSpec.describe 'forked' do
  it "sums the prices of its line items" do
    pids = (1..4).map do |n|
      fork do
        p n # Notice that these are not always in the same order: the test is concurrent.
        fail = true ## DEMO: change this to false to see the test pass.
        exit! 1 if fail
      end
    end

    pids.each do |pid|
      Process.wait(pid)
      expect($?.exitstatus).to eq(0)
    end
  end
end

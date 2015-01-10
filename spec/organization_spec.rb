require 'organization';

describe Organization do

  Given(:subject) { described_class.new }

  describe '.depth' do
    valid_depths = [0, 1, 2]
    valid_depths.each do |depth|
      context "can be set to #{depth}" do
        When(:result) { subject.depth = depth }
        Then { subject.depth == depth }
      end
    end
  end

end

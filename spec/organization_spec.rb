require 'organization';

describe Organization do
  Given(:subject) { described_class.new }

  describe '.depth' do
    When(:result) { subject.depth = depth_to_set }

    valid_depths = [0, 1, 2]
    valid_depths.each do |depth|
      context "can be set to #{depth}" do
        Given(:depth_to_set) { depth }
        Then { subject.depth == depth }
      end
    end

    context 'cannot be less than 0' do
      Given(:depth_to_set) { -1 }
      Then { result == Failure(ArgumentError, /depth can only be 0, 1, or 2/) }
    end

  end

end

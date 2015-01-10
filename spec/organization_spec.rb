require 'organization';

describe Organization do

  Given(:subject) { described_class.new }

  describe '.depth' do
    context 'can be set to 0' do
      When(:result) { subject.depth = 0 }
      Then { subject.depth == 0 }
    end
  end

end

require 'organization';

describe Organization do

  Given(:subject) { described_class.new }

  describe '#depth=' do
    When(:result) { subject.depth = depth_to_set }

    valid_depths = (Organization::MIN_DEPTH..Organization::MAX_DEPTH)
    valid_depths.each do |depth|
      context "can be set to #{depth}" do
        Given(:depth_to_set) { depth }
        Then { subject.depth == depth }
      end
    end

    context 'cannot be' do
      Invariant {
        result == Failure(ArgumentError,
          /depth must be between #{Organization::MIN_DEPTH} and #{Organization::MAX_DEPTH}/)
      }
      Invariant { subject.depth.nil? }

      context "less than #{Organization::MIN_DEPTH}" do
        Given(:depth_to_set) { Organization::MIN_DEPTH - 1 }
        Then { invariants_are_satisfied? }
      end

      context "greater than #{Organization::MAX_DEPTH}" do
        Given(:depth_to_set) { Organization::MAX_DEPTH + 1 }
        Then { invariants_are_satisfied? }
      end
    end

  end

  describe '#parent' do
    Given(:parent_to_set) { Organization.new }
    Given { subject.depth = depth_to_set }
    When(:result) { subject.parent = parent_to_set }

    context 'cannot be set if the organization is the root organization' do
      Given(:depth_to_set) { Organization::ROOT }
      Then {
        result ==
          Failure(ArgumentError, /root organization cannot have a parent/)
      }
    end

    context 'can be set if the organization is not a root organization' do
      valid_depths = (Organization::ROOT + 1..Organization::MAX_DEPTH)
      valid_depths.each do |depth|
        Given(:depth_to_set) { depth }
        Then { subject.parent == parent_to_set }
      end
    end

  end

end

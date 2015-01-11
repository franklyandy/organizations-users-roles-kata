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

  describe '#is_child_organization?' do
    Given { subject.depth = Organization::MAX_DEPTH }
    When(:result) { subject.is_child_organization? }
    Then { result }
  end

  describe '#parent' do
    Given(:parent) { Organization.new }
    Given { subject.depth = depth_to_set }
    When(:result) { subject.parent = parent }

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

        context 'and the parent is' do
          Invariant { subject.parent == parent }

          context 'the root organization' do
            Given { parent.depth = Organization::ROOT }
            Then { invariants_are_satisfied? }
          end

          context 'is a regular organization' do
            Given { parent.depth = Organization::MAX_DEPTH - 1 }
            Then { invariants_are_satisfied? }
          end
        end

        context 'and the parent is not a child organization' do
          Given { parent.depth = Organization::MAX_DEPTH }
          Then {
            result ==
              Failure(ArgumentError, /a child organization cannot be a parent/)
          }
        end

      end
    end

  end

end

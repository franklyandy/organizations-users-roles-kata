require 'organization';

describe Organization do

  describe 'initialize' do
    context 'defaults' do
      Then { !subject.parent.nil? }
      And { subject.parent.is_root? }
      And { subject.children.empty? }
    end

    context 'is root if parent is nil' do
      Given(:subject) { Organization.new(nil) }
      Then { subject.parent.nil? }
      And { subject.is_root? }
    end
  end

  describe '#depth' do
    context 'root' do
      Given(:subject) { Organization.new(nil) }
      Then { subject.depth == 0 }
    end

    context 'organization' do
      Then { subject.depth == 1 }
    end

    context 'child' do
      Given(:subject) { Organization.new(Organization.new) }
      Then { subject.depth == 2 }
    end
  end

  describe '#parent' do
    Given(:parent) { Organization.new }
    When(:result) { subject.parent = parent }

    context 'cannot be set if the organization is the root organization' do
      Given(:subject) { Organization.new nil }
      Given(:depth_to_set) { Organization::ROOT }
      Then {
        result ==
          Failure(ArgumentError, /root organization cannot have a parent/)
      }
    end

    context 'a child organization cannot be a parent' do
      Given(:parent) { Organization.new(Organization.new) }
      Then{
        result ==
          Failure(ArgumentError, /a child organization cannot be a parent/)
      }
    end
  end

  describe '#add_child' do
    Given(:child) { Organization.new }
    When(:result) { subject.add_child(child) }

    context 'children can be added' do
      Invariant { !subject.children.empty? }
      Invariant { child.parent == subject }

      context 'to the root organization' do
        Given(:subject) { Organization.new(nil) }
        Then { invariants_are_satisfied? }
      end

      context 'to a regular organization' do
        Then { invariants_are_satisfied? }
      end
    end

    context 'children cannot be added to a child organization' do
      Given(:subject) { Organization.new(Organization.new) }
      Then {
        result ==
          Failure(ArgumentError, /a child organization cannot be a parent/)
      }
      And { subject.children.empty? }
    end
  end

end

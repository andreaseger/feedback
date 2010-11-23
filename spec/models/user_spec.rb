require 'spec_helper'

describe User do
  describe '#scopes' do
    before do
      Factory(:amy)#student
      Factory(:intern)
      Factory(:prof)
      Factory(:admin)
    end
    it 'should only return students' do
      users = User.with_role("student").all
      users.count.should == 2
      users.each do |user|
        user.role?("student").should be_true
      end
    end
    %w(intern prof admin).each do |role|
      it "should only return #{role}s" do
        users = User.with_role(role).all
        users.count.should == 1
        users.each do |user|
          user.role?(role).should be_true
        end
      end
    end
  end

  describe '#roles' do
    it 'should not allow interns who are no students' do
      user = Factory.build(:bob, :roles => ["intern"])
      user.should_not be_valid
    end
    it 'should not allow users to be student and prof at the same time' do
      user = Factory.build(:bob, :roles => ["student", "prof"])
      user.should_not be_valid
    end
  end
end


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
end


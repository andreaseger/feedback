require 'spec_helper'
require "cancan/matchers"

describe Ability do
  before(:each) do
    Factory(:valid_sheet)
  end

  describe '#student' do
    before(:each) do
      user = Factory(:student, :roles => ["student"])
      @ability = Ability.new(user)
    end
    it 'should be able to read sheets' do
      @ability.should be_able_to(:read, Sheet.last)
    end
    it 'should not be able to manage any sheet' do
      @ability.should_not be_able_to(:create, Sheet.last)
      @ability.should_not be_able_to(:update, Sheet.last)
      @ability.should_not be_able_to(:destroy, Sheet.last)
    end
  end

  describe '#intern' do
    before(:each) do
      @user = Factory(:student, :roles => ["student"])
      @semester = Factory(:semester, :interns =>[@user])
      Semester.stubs(:current).returns(@semester)
      @ability = Ability.new(@user)
      @sheet = Factory(:valid_sheet, :user => nil)
    end
    it 'should be able to read sheets' do
      @ability.should be_able_to(:read, @sheet)
    end
    it 'should be able to create a sheet' do
      @ability.should be_able_to(:create, Sheet.new())
    end
    it 'should not be able to create a second sheet' do
      @own_sheet = Factory(:valid_sheet, :user => @user)
      @ability.should_not be_able_to(:create, Sheet.new())
    end
    it 'should be able to update his own sheet' do
      @own_sheet = Factory(:valid_sheet, :user => @user)
      @ability.should be_able_to(:update, @own_sheet)
    end
    it 'should not be able to update any other sheet' do
      @ability.should_not be_able_to(:update, @sheet)
    end
    it 'should not be able to delete his sheet' do
      @own_sheet = Factory(:valid_sheet, :user => @user)
      @ability.should_not be_able_to(:destroy, @own_sheet)
      @ability.should_not be_able_to(:destroy, @sheet)
    end
  end

  describe '#admin' do
    before(:each) do
      @user = Factory(:admin, :roles => ["admin"])
      @ability = Ability.new(@user)
      @sheet = Factory(:valid_sheet, :user => nil)
      @own_sheet = Factory(:valid_sheet, :user => @user)
    end
    it 'should be able to manage all sheets' do
      @ability.should be_able_to(:manage, @own_sheet)
      @ability.should be_able_to(:manage, @sheet)
      @ability.should be_able_to(:manage, Sheet.new)
    end
  end

  describe '#extern' do
    before(:each) do
      user = Factory(:extern, :roles => ["extern"])
      @ability = Ability.new(user)
    end
    it 'should be able to read sheets' do
      @ability.should be_able_to(:read, Sheet.last)
    end
    # TODO Klären wie hier die Rechte aussehen sollen
  end
end


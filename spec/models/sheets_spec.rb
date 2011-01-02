require 'spec_helper'

describe Sheet do
  context '#validations' do
    %w(reachability accessability working_atmosphere satisfaction_with_support stress_factor apartment_market satisfaction_with_internship independent_work reference_to_the_study learning_effect required_previous_knowledge).each do |attrib|
      context "##{attrib}" do
        it "should be invalid if greater than 4" do
          sheet = Factory.build(:valid_sheet, attrib => 5)
          sheet.should_not be_valid
        end
        it "should be invalid if less than 1" do
          sheet = Factory.build(:valid_sheet, attrib => -2)
          sheet.should_not be_valid
        end
        it "should be valid if 3" do
          sheet = Factory.build(:valid_sheet, attrib => 3)
          sheet.should be_valid
        end
      end
    end
    Factory.attributes_for(:valid_sheet).keys.each do |attrib|
      it "#{attrib} has to be present" do
        sheet = Factory.build(:valid_sheet, attrib => nil)
        sheet.should_not be_valid
      end
    end
  end

  context '#languages' do
    context '#split' do
      it 'should split strings with a dot correctly' do
        v = "foo. lorem"
        Sheet.split_languages(v).should == ["foo", "lorem"]
      end
      it 'should split strings with a comma correctly' do
        v= "foo, lorem"
        Sheet.split_languages(v).should == ["foo", "lorem"]
      end
      it 'should split strings with a space correctly' do
        v="foo lorem"
        Sheet.split_languages(v).should == ["foo", "lorem"]
      end
      it 'should split the input on space, komma' do
        v = "greek spanish, english,latin"
        Sheet.split_languages(v).should == ["greek", "spanish", "english", "latin"]
      end
    end
    it 'should give a string of all assigned speeches' do
      sheet = Factory.build(:valid_sheet, :required_languages => nil, :speeches=>["foo", "bar", "baz", "lorem"])
      sheet.required_languages.should == "foo bar baz lorem"
    end
  end

  context 'search' do
    # the attributes are sorted in arrays
    # not really  TDD like, because this only tests the implementation
    context '#text attributes' do
      it 'should create a criteria where for text attributes' do
        s = {"company" => "audi"}
        Sheet.search(s).should == Sheet.where(:company => /audi/i)
      end
      it 'should merge the criteria for multiple text attribues' do
        s = {"company" => "audi", "department" => "aa BB cc"}
        Sheet.search(s).should == Sheet.where(:company => /audi/i).and(:department => /aa BB cc/i)
      end
    end
    context '#boolean attributes' do
      it 'should create a criteria where for boolean attributes' do
        s = {"vacation" => "false"}
        Sheet.search(s).should == Sheet.where(:vacation => "false")
      end
      it 'should merge the criteria for multiple boolean attribues' do
        s = {"vacation" => "false", "release" => "true"}
        Sheet.search(s).should == Sheet.where(:vacation => false).and(:release => true)
      end
    end
    context '#number attributes' do
      it 'should create a criteria with less than for number attributes' do
        s = {"working_hours" => 30 }
        Sheet.search(s).should == Sheet.where(:working_hours.lte => 30)
      end
      it 'should create a criteria with greater than for number attributes' do
        s = {"apartment_market" => 2 }
        Sheet.search(s).should == Sheet.where(:apartment_market.gte => 2)
      end

      it 'should merge the criteria for multiple number attribues with less than or equal' do
        s = {"working_hours" => 30, "stress_factor" => 2}
        Sheet.search(s).should == Sheet.where(:working_hours.lte => 30).and(:stress_factor.lte => 2)
      end
      it 'should merge the criteria for multiple number attribues with greater than or equal' do
        s = {"reachability" => 2, "apartment_market" => 2}
        Sheet.search(s).should == Sheet.where(:reachability.gte => 2).and(:apartment_market.gte => 2)
      end

      it 'should merge the criteria for multiple number attribues with mixed directions' do
        s = {"working_hours" => 30, "apartment_market" => 2}
        Sheet.search(s).should == Sheet.where(:working_hours.lte => 30).and(:apartment_market.gte => 2)
      end
    end
    context '#people search' do
      it 'should search for both boss and handler' do
        s = {"people" => "foo"}
        Sheet.search(s).should == Sheet.any_of({:handler => /foo/i},{:boss => /foo/i})
      end
      it 'should search for both boss and handler also for the attribut handler' do
        s = {"handler" => "foo"}
        Sheet.search(s).should == Sheet.any_of({:handler => /foo/i},{:boss => /foo/i})
      end
    end

    context '#speeches' do
      it 'should search for both boss and handler' do
        s = {"required_languages" => "foo bar"}
        Sheet.search(s).should == Sheet.any_in(:speeches => [/foo/i, /bar/i])
      end
    end

    context '#addresses' do
      it 'should search in the addresses' do
        s = {"application_address" => "foo"}
        Sheet.search(s).should == Sheet.any_of( {'application_address.city' => /foo/i},
                                                {'application_address.street' => /foo/i},
                                                {'application_address.post_code' => /foo/i},
                                                {'application_address.country' => /foo/i},
                                                {'job_site_address.city' => /foo/i},
                                                {'job_site_address.street' => /foo/i},
                                                {'job_site_address.post_code' => /foo/i},
                                                {'job_site_address.country' => /foo/i} )
      end
    end


    context '#mixed attributes' do
      it 'should work with text and boolean attributes' do
        s = {"vacation" => "false", "company" => "audi"}
        Sheet.search(s).should == Sheet.where(:company => /audi/i).and(:vacation => false)
      end
      it 'should work with text and number attributes' do
        s = {"company" => "audi", "apartment_market" => 2}
        Sheet.search(s).should == Sheet.where(:company => /audi/i).and(:apartment_market.gte => 2)
      end
      it 'should work with boolean and number attributes' do
        s = {"vacation" => "false", "apartment_market" => 2}
        Sheet.search(s).should == Sheet.where(:vacation => false).and(:apartment_market.gte => 2)
      end
      it 'should work with text, boolean and number attributes' do
        s = {"company" => "audi", "vacation" => "false", "apartment_market" => 2}
        Sheet.search(s).should == Sheet.where(:company => /audi/i).and(:apartment_market.gte => 2).and(:vacation => false)
      end
      it 'should work with all sorts of attributes' do
        s = {"company" => "audi", "vacation" => "false", "apartment_market" => 2, "people" => "foo"}
        Sheet.search(s).should == Sheet.where(:company => /audi/i).and(:apartment_market.gte => 2).and(:vacation => false).any_of({:handler => /foo/i},{:boss => /foo/i})
      end
    end

  end
end


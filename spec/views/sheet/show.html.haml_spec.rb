require 'spec_helper'

describe "/sheets/show.html.haml" do

  before do
    #mockmock
  end

  it 'should show me the sheets companie' do
    render
    rendered.should have_content("Opel")
  end
end


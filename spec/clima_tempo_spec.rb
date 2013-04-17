require "spec_helper"

describe ClimaTempo do
  it "missing parameters" do
    expect { climatempo = ClimaTempo.new }.to raise_error(ArgumentError)
  end

  context "values for the time" do
    before do
      fixture = File.open("spec/fixture/sao_paulo.html").read
      FakeWeb.register_uri :any, "http://www.climatempo.com.br/previsao-do-tempo/cidade/558/empty", :body => fixture

      @climatempo = ClimaTempo.new :code => 558
    end

    it "object type" do
      @climatempo.now.should be_an(Hash)
    end

    it "keys" do
      hash = @climatempo.now

      hash.should have(7).items

      hash.should have_key(:temperature)
      hash.should have_key(:wind)
      hash.should have_key(:condition)
      hash.should have_key(:pressure)
      hash.should have_key(:intensity)
      hash.should have_key(:moisture)
      hash.should have_key(:video)
    end

    it "values" do
      hash = @climatempo.now

      hash[:temperature].should == "24ºC"
      hash[:wind].should == "Sudeste"
      hash[:condition].should == "Muitas nuvens"
      hash[:pressure].should == "1021 hPa"
      hash[:intensity].should == "19 Km/h"
      hash[:moisture].should == "57%"
      hash[:video].should include("grande-sp")
    end
  end
end

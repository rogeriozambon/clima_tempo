require "spec_helper"

describe ClimaTempo do
  it "missing type" do
    expect { climatempo = ClimaTempo.new(:code) }.to raise_error(TypeError)
  end

  it "missing parameters" do
    expect { climatempo = ClimaTempo.new }.to raise_error(ArgumentError)
    expect { climatempo = ClimaTempo.new({}) }.to raise_error(ArgumentError)
  end

  context "values from São Paulo" do
    before do
      fixture = File.open("spec/fixture/sao_paulo.html").read
      FakeWeb.register_uri :any, "http://www.climatempo.com.br/previsao-do-tempo/cidade/558/empty", :body => fixture

      @clima_tempo = ClimaTempo.new :code => 558
    end

    it "object type" do
      @clima_tempo.now.should be_an(Hash)
    end

    it "object keys" do
      hash = @clima_tempo.now

      hash.should have(6).items

      hash.should have_key(:temperature)
      hash.should have_key(:wind)
      hash.should have_key(:condition)
      hash.should have_key(:pressure)
      hash.should have_key(:intensity)
      hash.should have_key(:moisture)
    end

    it "object values" do
      hash = @clima_tempo.now

      hash[:temperature].should == "28ºC"
      hash[:wind].should == "Norte"
      hash[:condition].should == "Tempo firme"
      hash[:pressure].should == "1017 hPa"
      hash[:intensity].should == "11 Km/h"
      hash[:moisture].should == "51%"
    end
  end
end

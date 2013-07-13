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

    it "now object type" do
      @clima_tempo.now.should be_an(Hash)
    end

    it "now object keys" do
      hash = @clima_tempo.now

      hash.should have(6).items

      hash.should have_key(:temperature)
      hash.should have_key(:wind)
      hash.should have_key(:condition)
      hash.should have_key(:pressure)
      hash.should have_key(:intensity)
      hash.should have_key(:moisture)
    end

    it "now object values" do
      hash = @clima_tempo.now

      hash[:temperature].should == "28ºC"
      hash[:wind].should == "Norte"
      hash[:condition].should == "Tempo firme"
      hash[:pressure].should == "1017 hPa"
      hash[:intensity].should == "11 Km/h"
      hash[:moisture].should == "51%"
    end

    it "today forecast type" do
      @clima_tempo.today_forecast.should be_an(Hash)
    end

    it "today forecast keys" do
      hash = @clima_tempo.today_forecast

      hash.should have(4).items

      hash.should have_key(:condition)
      hash.should have_key(:min)
      hash.should have_key(:max)
      hash.should have_key(:probability_of_precipitation)
    end

    it "today forecast values" do
      hash = @clima_tempo.today_forecast

      hash[:condition].should == "Dia de sol, com nevoeiro ao amanhecer. As nuvens aumentam no decorrer da tarde."
      hash[:min].should == "17º"
      hash[:max].should == "30º"
      hash[:probability_of_precipitation].should == "0%"
    end



  end
end

require "spec_helper"

describe ClimaTempo do
  it "missing code" do
    expect { ClimaTempo.new }.to raise_error(ArgumentError)
  end

  context "values from São Paulo" do
    before do
      fixture = File.open("spec/fixture/sao_paulo.html").read
      FakeWeb.register_uri :any, "http://www.climatempo.com.br/previsao-do-tempo/cidade/558/empty", :body => fixture
    end

    it "now's values" do
      clima_tempo = ClimaTempo.new(558).now

      expect(clima_tempo[:temperature]).to eq("22ºC")
      expect(clima_tempo[:wind]).to eq("Su-sudeste")
      expect(clima_tempo[:condition]).to eq("Muitas nuvens")
      expect(clima_tempo[:pressure]).to eq("1015 hPa")
      expect(clima_tempo[:intensity]).to eq("11 km/h")
      expect(clima_tempo[:moisture]).to eq("73%")
    end

    it "today forecast's values" do
      clima_tempo = ClimaTempo.new(558).today_forecast

      expect(clima_tempo[:condition]).to eq("Sol com muitas nuvens. Pancadas de chuva à tarde e à noite.")
      expect(clima_tempo[:min]).to eq("17º")
      expect(clima_tempo[:max]).to eq("27º")
      expect(clima_tempo[:probability_of_precipitation]).to eq("64%")
    end
  end
end

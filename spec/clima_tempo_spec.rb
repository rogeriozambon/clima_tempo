require_relative "../lib/clima_tempo"

describe ClimaTempo do
  it "missing parameters" do
    expect { climatempo = ClimaTempo.new }.to raise_error(ArgumentError)
  end

  context "Values up to this moment" do
    before do
      fixture = File.open("spec/fixture/sao_paulo.html").read
      parser = Nokogiri::HTML fixture

      @climatempo = ClimaTempo.new :code => 558
      @climatempo.stub(:request_page).and_return parser
    end

    it "check object types" do
      @climatempo.now.should be_an(Hash)
    end

    it "check hash keys" do
      hash = @climatempo.now

      hash.should have_key(:temperature)
      hash.should have_key(:wind)
      hash.should have_key(:condition)
      hash.should have_key(:pressure)
      hash.should have_key(:intensity)
      hash.should have_key(:humidity)
      hash.should have_key(:video)
    end
  end
end

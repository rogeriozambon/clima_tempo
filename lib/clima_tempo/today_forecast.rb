class TodayForecast
  def initialize(request)
    @request = request
  end

  def data
    {
      condition: condition,
      min: minimum,
      max: maximum,
      probability_of_precipitation: precipitation
    }
  end

  private
  def condition
    @request.xpath("//#{base_div}/span[@class='left left5 paragrafo-padrao top10 fraseologia-prev']").text
  end

  def minimum
    @request.xpath("//#{base_div}//span[@class='min']").text.gsub(/\s+/,'')
  end

  def maximum
    @request.xpath("//#{base_div}//span[@class='max']").text
  end

  def precipitation
    @request.xpath("//#{base_div}//li[@class='prob-chuva-prev-completa list-style-none']/span//a[2]").text.gsub(/^\d+mm/, "")
  end

  def base_div
    "div[@class='box-prev-completa'][1]"
  end
end

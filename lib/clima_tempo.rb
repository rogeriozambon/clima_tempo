# -*- encoding: utf-8 -*-
require "net/http"
require "nokogiri"

class ClimaTempo
  attr_reader :code

  def initialize(option)
    raise TypeError unless option.kind_of? Hash
    raise ArgumentError unless option.has_key? :code

    @code = option[:code]
  end

  def now
    @page ||= request

    {
      :temperature => @page[:temperature].text,
      :wind => wind[prepare(@page[:data][0].text)],
      :condition => prepare(@page[:data][1].text),
      :pressure => prepare(@page[:data][2].text),
      :intensity => prepare(@page[:data][3].text),
      :moisture => prepare(@page[:data][4].text)
    }
  end

  def today_forecast
    @page ||= request

    {
      :condition => @page[:today_forecast][:condition].text,
      :min => @page[:today_forecast][:min].text.gsub(/\s+/,''),
      :max => @page[:today_forecast][:max].text,
      :probability_of_precipitation => @page[:today_forecast][:probability_of_precipitation].text.gsub(/^\d+mm/,'')
    }

  end

  private
  def request
    request = Net::HTTP.get URI.parse("http://www.climatempo.com.br/previsao-do-tempo/cidade/#{@code}/empty")
    request = Nokogiri::HTML request

    {
      :temperature => request.xpath("//span[@class='left temp-momento top10']"),
      :data => request.xpath("//li[@class='dados-momento-li list-style-none']"),
      :today_forecast => {
        :condition => request.xpath("//div[@class='box-prev-completa'][1]/span[@class='left left5 paragrafo-padrao top10 fraseologia-prev']"),
        :min => request.xpath("//div[@class='box-prev-completa'][1]//span[@class='min']"),
        :max => request.xpath("//div[@class='box-prev-completa'][1]//span[@class='max']"),
        :probability_of_precipitation => request.xpath("//div[@class='box-prev-completa'][1]//li[@class='prob-chuva-prev-completa list-style-none']/span[2]")
      }
    }
  end

  def prepare(value)
    value.gsub! /^.+:\s*/, ""
  end

  def wind
    {
      "N" => "Norte",
      "S" => "Sul",
      "E" => "Leste",
      "W" => "Oeste",
      "NE" => "Nordeste",
      "NW" => "Noroeste",
      "SE" => "Sudeste",
      "SW" => "Sudoeste",
      "ENE" => "Lés-nordeste",
      "ESE" => "Lés-sudeste",
      "SSE" => "Su-sudeste",
      "NNE" => "Nor-nordeste",
      "NNW" => "Nor-noroeste",
      "SSW" => "Su-sudoeste",
      "WSW" => "Oés-sudoeste",
      "WNW" => "Oés-noroeste"
    }
  end
end

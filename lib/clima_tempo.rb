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
    page = request

    {
      :temperature => page[:temperature].text,
      :wind => wind[prepare(page[:data][0].text)],
      :condition => prepare(page[:data][1].text),
      :pressure => prepare(page[:data][2].text),
      :intensity => prepare(page[:data][3].text),
      :moisture => prepare(page[:data][4].text)
    }
  end

  private
  def request
    request = Net::HTTP.get URI.parse("http://www.climatempo.com.br/previsao-do-tempo/cidade/#{@code}/empty")
    request = Nokogiri::HTML request

    {
      :temperature => request.xpath("//span[@class='left temp-momento top10']"),
      :data => request.xpath("//li[@class='dados-momento-li list-style-none']")
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

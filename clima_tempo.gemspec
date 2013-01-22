# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.authors = ["Rogério Zambon"]
  s.date = "2013-01-22"
  s.description = "Get brazilian weather values of the ClimaTempo"
  s.email = "rogeriozambon@gmail.com"
  s.add_dependency "rest-client", ">= 1.6.7"
  s.add_dependency "nokogiri", ">= 1.5.6"
  s.files = [
    "lib/clima_tempo.rb",
    "spec/clima_tempo_spec.rb",
    "spec/fixture/sao_paulo.html",
    "VERSION",
    "clima_tempo.gemspec"
  ]
  s.homepage = "http://github.com/rogeriozambon/clima_tempo"
  s.name = "clima_tempo"
  s.require_paths = ["lib"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.23")
  s.summary = s.description
  s.version = "1.0"
end

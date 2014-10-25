class Wind < String
  def initialize(initial)
    super(map[initial])
  end

  private
  def map
    {
      "Direção do Vento: N" => "Norte",
      "Direção do Vento: S" => "Sul",
      "Direção do Vento: E" => "Leste",
      "Direção do Vento: W" => "Oeste",
      "Direção do Vento: NE" => "Nordeste",
      "Direção do Vento: NW" => "Noroeste",
      "Direção do Vento: SE" => "Sudeste",
      "Direção do Vento: SW" => "Sudoeste",
      "Direção do Vento: ENE" => "Lés-nordeste",
      "Direção do Vento: ESE" => "Lés-sudeste",
      "Direção do Vento: SSE" => "Su-sudeste",
      "Direção do Vento: NNE" => "Nor-nordeste",
      "Direção do Vento: NNW" => "Nor-noroeste",
      "Direção do Vento: SSW" => "Su-sudoeste",
      "Direção do Vento: WSW" => "Oés-sudoeste",
      "Direção do Vento: WNW" => "Oés-noroeste"
    }
  end
end

class Character
  attr_reader :codepoint, :name, :major_category, :minor_category,
              :abbreviation, :alternate, :correction, :figment

  def initialize(codepoint, name, major_category, minor_category,
                 abbreviation="", alternate="", correction="", figment="")
    @codepoint = codepoint
    @name = name
    @major_category = major_category
    @minor_category = minor_category
    @abbreviation = abbreviation
    @alternate = alternate
    @correction = correction
    @figment = figment
  end
end

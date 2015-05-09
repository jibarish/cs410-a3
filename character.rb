class Character
  attr_reader :codepoint, :name, :major_category, :minor_category,
              :alternate, :figment, :correction

  def initialize(codepoint, name, major_category, minor_category,
                 alternate="", figment="", correction="")
    @codepoint = codepoint
    @name = name
    @major_category = major_category
    @minor_category = minor_category
    @alternate = alternate
    @figment = figment
    @correction = correction
  end
end

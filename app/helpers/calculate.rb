class Calculate

  def initialize(number)
    @number = number
  end

  def pierwiastek(stopien)
    @number.to_r ** (1.0/stopien)
  end

  def pole
    Math::PI * @number **2
  end

end
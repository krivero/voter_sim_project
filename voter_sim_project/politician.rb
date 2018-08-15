class Politician
  attr_accessor :name, :party, :votes

  def initialize(name, party)
    @name = name
    @party = party
    @votes = 0
  end

  def get_info
    "Politician, #{@name}, #{@party}"
  end
end

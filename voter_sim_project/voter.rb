class Voter
  attr_accessor :name, :politics

  def initialize(name, politics)
    @name = name
    @politics = politics
  end

  #Access each voters name and politics in string format
  def get_info
    "Voter, #{@name}, #{@politics}"
  end
end

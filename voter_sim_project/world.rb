POLITICAL_PARTY = {l: "Liberal", c: "Conservative", t: "Tea Party", s: "Socialist", n: "Neutral"}
PARTY_AFF = {d: "Democrat", r: "Republican"}

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


class World
  attr_accessor :voters, :politicians, :total_votes

  def initialize
    @voters_politicians = []
    @total_votes = {} #Associated with each politician
  end

  def create_voter(name, politics)
    p name
    p politics
    @voters_politicians << Voter.new(name, politics)
  end

  def create_politician(name, party)
    @voters_politicians << Politician.new(name, party)
  end

  def formatted_voters
    @voters_politicians.each do |voter|
      puts voter.get_info if voter.is_a?(Voter)
    end
  end

  def formatted_politicians
    @voters_politicians.each do |politician|
      puts politician.get_info if politician.is_a?(Politician)
    end
  end

  def choices(choice)
    case choice
      when "c"
        create
      when "l"
        formatted_voters
        formatted_politicians
        continue
      when "u"
        update
      when "d"
        delete
      end
  end

  def continue
    puts "What would you like to do next?"
    puts "(C)reate, (L)ist, (U)pdate, or (D)elete"
      while choice = gets.chomp.downcase
        case choice
        when "c", "l", "u", "d"
          choices(choice)
        else
          puts "Invalid choice. Try again."
          continue
        end
      end
  end

  def start
    puts "What would you like to do?"
    puts "(C)reate, (L)ist, (U)pdate, or (D)elete"
      while choice = gets.chomp.downcase
        case choice
        when "c", "l", "u", "d"
          choices(choice)
        else
          puts "Invalid choice. Try again."
          continue
        end
      end
  end


  def createPolitician
    puts "Name?"
    name_of_p = gets.chomp
    puts "Party?"
    puts "(D)emocrat or (R)epublican"
    while party_of_p = gets.chomp.downcase
      case party_of_p
      when "d", "r"
        create_politician(name_of_p, PARTY_AFF[party_of_p.to_sym])
        puts "Politician has been created."
        continue
      else
        puts "Invalid choice. Please try again."
        create
      end
    end
  end

  def createVoter
    puts "Name?"
    name_of_v = gets.chomp.downcase
    puts "Politics?"
    puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
    while politics_of_v = gets.chomp.downcase
      case politics_of_v
      when "l", "c", "t", "s", "n"
        create_voter(name_of_v, POLITICAL_PARTY[politics_of_v.to_sym])
        puts "Voter has been created."
        continue
      else
        puts "Invalid choice. Please try again."
        create
      end
    end
  end

  def create
    puts "What would you like to create?"
    puts "(P)olitician or (V)oter"
    while type_of = gets.chomp.downcase
      case type_of
      when "p"
        createPolitician
      when "v"
        createVoter
      end
    end
      continue
   end

  def updatePolitician(person)
    puts "New Party?"
    puts "(D)emocrat or (R)epublican"
    while new_party = gets.chomp.downcase
      case new_party
      when "d", "r"
        person.party = PARTY_AFF[new_party.to_sym]
        continue
      else
        puts "Invalid choice. Please try again."
        update
      end
    end
  end

  def updateVoter(person)
    puts "New Politics?"
    puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
    while new_politics = gets.chomp.downcase
      case new_politics
      when "l", "c", "t", "s", "n"
        person.politics = POLITICAL_PARTY[new_politics.to_sym]
        continue
      else
        puts "Invalid choice. Please try again."
        update
      end
    end
  end

  def update
    puts "Who would you like to update?"
    name_of_u = gets.chomp
    pol_voters = @voters_politicians
    pol_voters.each do |person|
      if name_of_u == person.name
        puts "New name?"
        new_name_of_u = gets.chomp
        person.name = new_name_of_u
        if person.class.to_s == "Politician"
          updatePolitician(person)
        else
          updateVoter(person)
        end
      end
      continue
    end
  end


  def delete
    puts "Who would you like to delete?"
    person_to_delete = gets.chomp
    pol_voters = [@voters, @politicians].flatten
    pol_voters.each do |person|
      if person_to_delete == person.name
        puts "Are you sure?"
        puts "(Y)es"
        if gets.chomp.downcase == "y"
          if person.class.to_s == "Politician"
            @politicians.delete(person)
          else
            @voters.delete(person)
          end
        end
      end
    end
    continue
    end
end



world = World.new

world.start

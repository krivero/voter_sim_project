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
    @voters = []
    @politicians = []
    @total_votes = {} #Associated with each politician
  end

  def create_voter(name, politics)
    p name
    p politics
    @voters << Voter.new(name, politics)
  end

  def create_politician(name, party)
    @politicians << Politician.new(name, party)
  end

  def formatted_voters
    @voters.each do |voter|
      puts voter.get_info
    end
  end

  def formatted_politicians
    @politicians.each do |politician|
      puts politician.get_info
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
      choice = gets.chomp.downcase
      choices(choice)
  end

  def start
    puts "What would you like to do?"
    puts "(C)reate, (L)ist, (U)pdate, or (D)elete"
    choice = gets.chomp.downcase
    choices(choice)
    continue
  end

  def create
    puts "What would you like to create?"
    puts "(P)olitician or (V)oter"
    type_of = gets.chomp.downcase
      if type_of == "p"
        puts "Name?"
        name_of_p = gets.chomp
        puts "Party?"
        puts "(D)emocrat or (R)epublican"
        party_of_p = gets.chomp.downcase
        unless party_of_p == "d" or "r"
          create_politician(name_of_p, PARTY_AFF[party_of_p.to_sym])
          puts inspect
        else
          puts "Invalid choice. Please try again."
        end
      elsif type_of == "v"
        puts "Name?"
        name_of_v = gets.chomp.downcase
        puts "Politics?"
        puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
        politics_of_v = gets.chomp.downcase
        create_voter(name_of_v, POLITICAL_PARTY[politics_of_v.to_sym])
        puts inspect
        else
          puts "Invalid choice. Please try again."
      end
      create
    end


    def update
      puts "Who would you like to update?"
      name_of_u = gets.chomp
      pol_voters = [@voters, @politicians].flatten
      pol_voters.each do |person|
        if name_of_u == person.name
          puts "New name?"
          new_name_of_u = gets.chomp
          person.name = new_name_of_u
          #If person is a Politician
          if person.class.to_s == "Politician"
            puts "New Party?"
            puts "(D)emocrat or (R)epublican"
            new_party = gets.chomp
            person.party = PARTY_AFF[new_party.to_sym]
          else
          #If person is a Voter
            puts "New Politics?"
            puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
            new_politics = gets.chomp
            person.politics = POLITICAL_PARTY[new_politics.to_sym]
          end
        end
    end
      continue
    end


    def delete
      #Asked to input name of character they wish to delete
      #If name matches an existing person, they are asked if they are sure and need to input (Y)es
      #It should delete that person
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

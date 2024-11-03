
class Players
  HANDSIZE = 7

  attr_accessor :hand, :score, :letters, :direction, :row, :column
  #creates the Players
  def initialize
    @hand = Array.new(HANDSIZE)
    @score = 0
  end

  def display_hand
    puts hand.join(", ")
  end
  #creates the hand of the Players
  def create_hand
    HANDSIZE.times do |hand_index|
      randm_num = rand(1..100)
      if hand[hand_index].nil?
        hand[hand_index] = case randm_num
                           when 1..9 then "A"
                           when 10..11 then "B"
                           when 12..13 then "C"
                           when 14..17 then "D"
                           when 18..29 then "E"
                           when 30..31 then "F"
                           when 32..34 then "G"
                           when 35..36 then "H"
                           when 37..45 then "I"
                           when 46 then "J"
                           when 47 then "K"
                           when 48..51 then "L"
                           when 52..53 then "M"
                           when 54..59 then "N"
                           when 60..67 then "O"
                           when 68..69 then "P"
                           when 70 then "Q"
                           when 71..76 then "R"
                           when 77..80 then "S"
                           when 81..86 then "T"
                           when 87..90 then "U"
                           when 91..92 then "V"
                           when 93..94 then "W"
                           when 95 then "X"
                           when 96..97 then "Y"
                           else "Z"
                           end
      end
    end
  end
end

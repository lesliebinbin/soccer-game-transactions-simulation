module Typecasts::General
  class <<self
    def cast_to_number(value, splitor = nil)
      first_num, second_num = value.split(splitor)
      if second_num.nil?
        first_num.to_f
      else
        Range.new(first_num.to_f, second_num.to_f)
      end
    end
  end
end

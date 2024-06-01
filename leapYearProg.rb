#Author: Khang Tran
#A program that repeatedly takes in a year 
#and determines if it is a leap year or not.
def checkLeapYear?(year)
    if year % 400 == 0
        true
    elsif (year % 4 == 0) && (year % 100 == 0) 
        if(year % 400 != 0)
            false
        else                
            true
        end
    elsif (year % 4 == 0) && (year % 100 != 0)
        true
    elsif year % 4 != 0
        false
    end
end

i = true
until i != true
    year = gets
    break if year == 0
    if checkLeapYear?(year)
        puts "#{year} is a leap year"
    else
        puts "#{year} is a leap year"
    end
end

        
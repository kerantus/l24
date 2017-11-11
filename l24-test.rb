a="mail@mail.ru"

a1 = a.scan(/[a-zA-Z@.]/)
print a1.find_all {|value| value == "@"}
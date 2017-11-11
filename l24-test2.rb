if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end



require "pony"
require "io/console"

my_mail = "kegz@mail.ru"
puts "Введите пароль: "
password =STDIN.gets.chomp #неотображать вводимые символы

puts "Адресат: "
sent_to = STDIN.gets.chomp

puts "Текст письма: "
body = STDIN.gets.chomp.encode("UTF-8")

begin #обработка ошибок

  Pony.mail(
      {
          :subject => "привет от руби",
          :body => body,
          :to => sent_to,
          :from => my_mail,

          :via => :smtp,
          :via_options => {
              :address => 'smtp.mail.ru',
              :port => '465',
              :tls => true,
              :user_name => my_mail,
              :password => password,
              :authentication => :plain
          }
      }
  )
  puts "Успешно отправлено"
rescue Net::SMTPAuthenticationError => error
  puts " Ошибка аутентификации " + error.message.to_s
rescue Net::SMTPFatalError => error
  puts  " Проверьте данные адресата " + error.message
    # puts "Не удалось отправить письмо"
ensure
  #puts "Попытка отправки письма закончена"
end #обработка ошибок
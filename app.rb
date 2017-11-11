#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School!!!!!!!!!!!!!!</a>"
end
get '/about' do
  erb :about
end

get '/writeof' do
  erb :visit
end

post '/writeof' do
  @user_name = params[:user_name]
  @user_phone = params[:user_phone]
  @user_time = params[:user_time]
  @user_master = params[:user_master]
  @user_color = params[:color]
  @title = 'Thank you'
  @message = "#{@user_name}, вы записаны к #{@user_master} на #{@user_time}"

  f = File.open "./public/users.txt", "a"
  f.write "\n #{@user_master} \n #{@user_time} -- #{@user_phone} -- #{@user_name} -- #{@user_color} \n"
  f.close
  erb :message
end




get '/contacts' do
	erb :contacts
end

post '/contacts' do
  @user_email = params[:user_email]
  @user_message = params[:user_message]
  @title = 'Thank you'
  f = File.open "./public/contacts.txt", "a"
  f.write "\n #{@user_email} \n #{@user_message} \n =============================================================== \n"
  f.close
  erb :contacts
end


get '/login' do
  erb :login
end

post '/login/attempt' do
  @username = params[:username]
  @pass = params[:pass]
  if @username == "admin" && @pass == "secret"
    session[:identity] = params['username']
    where_user_came_from = session[:previous_url] || '/'
    redirect to where_user_came_from
  else
    where_user_came_from = session[:previous_url] || '/login/attempt'
    redirect to where_user_came_from
    @message = "Доступ запрещён"
  end
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end
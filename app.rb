require 'sinatra'
require 'sendgrid-ruby'

include SendGrid


get '/' do
  erb :index
end

get '/muffins' do
  erb :muffins
end

get '/cakes' do
  erb :cakes
end

get '/cupcakes' do
  erb :cupcakes
end

get "/contct" do  
  puts ENV["SENDGRID_API_KEY"]
  
erb (:index)
end

post "/contact" do
  from = Email.new(email: 'garth.puckerin@gmail.com')
  to = Email.new(email: params[:email_address])
  subject = 'Thank you for joing our mailing list'
  content = Content.new(
    type: 'text/HTML', 
    value: params[:comment]
  )
  
  # create mail object with from, subject, to and content
  mail = Mail.new(from, subject, to, content)
  
  # sets up the api key
  sg = SendGrid::API.new(
    api_key: ENV["SENDGRID_API_KEY"]
  )
  
  # sends the email
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  
  # display http response code
  puts response.status_code
  
  # display http response body
  puts response.body
  
  # display http response headers
  puts response.headers
  

erb (:contact)
end

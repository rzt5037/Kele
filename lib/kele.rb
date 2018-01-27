require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(mail,pass)
    auth = "email=" + mail + "&password=" + pass
    headers = {:content_type => 'application/json'}

    user_info = self.class.post('/sessions?' + auth)
    if user_info.success?
      p user_info["auth_token"]
    else
      p "Wrong information entered."
    end
  end
end

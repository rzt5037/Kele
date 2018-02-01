require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(mail,pass)
    user_pass = "email=" + mail + "&password=" + pass
    auth = self.class.post('/sessions?' + user_pass)


    if auth.success?
      @auth_token = auth["auth_token"]
      p "Successful entry."
    else
      p "Wrong information entered."
    end
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get('/mentors/' + mentor_id.to_s + '/student_availability', headers: {"authorization" => @auth_token})
    mentor_data = JSON.parse(response.body)
    mentor_data.to_a
  end

  def roadmapper(roadmap_id)
    get_roadmap(roadmap_id)
  end

  def checkpointer(checkpoint_id)
    get_checkpoint(checkpoint_id)
  end
end

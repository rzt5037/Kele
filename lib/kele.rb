require 'httparty'
require 'json'
require './lib/roadmap.rb'
require "awesome_print"

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(mail,pass)
    @user = mail

    user_pass = "email=" + mail + "&password=" + pass
    auth = self.class.post('/sessions?' + user_pass, headers: {"content_type" => 'application/json'})

    if auth.success?
      @auth_token = auth["auth_token"]
      p "Successful entry."
    else
      p "Wrong information entered."
    end
  end

  def get_me
    response = self.class.get('/users/me', headers: {"content_type" => 'application/json',"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get('/mentors/' + mentor_id.to_s + '/student_availability', headers: {"content_type" => 'application/json',"authorization" => @auth_token})
    mentor_data = JSON.parse(response.body)
    mentor_data.to_a
  end

  def roadmapper(roadmap_id)
    get_roadmap(roadmap_id)
  end

  def checkpointer(checkpoint_id)
    get_checkpoint(checkpoint_id)
  end

  def get_messages(page = nil)
    if page
      response = self.class.get('/message_threads?page=' + page.to_s, headers: {"content_type" => 'application/json',"authorization" => @auth_token})
    else
      response = self.class.get('/message_threads', headers: {"content_type" => 'application/json',"authorization" => @auth_token})
    end
    JSON.parse(response.body)
  end

  def create_message(recipient,title,body,token_id = nil)
    if token_id
      self.class.post('/messages?sender=' + @user + '&recipient_id=' + recipient.to_s + '&token=' + token_id.to_s + '&subject=' + title + '&stripped-text=' + body, headers: {"content_type" => 'application/json',"authorization" => @auth_token})
    else
      self.class.post('/messages?sender=' + @user + '&recipient_id=' + recipient.to_s + '&subject=' + title + '&stripped-text=' + body, headers: {"content_type" => 'application/json',"authorization" => @auth_token})
    end
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    self.class.post('/messages?checkpoint_id=' + checkpoint_id.to_s + '&assignment_branch=' + assignment_branch + '&assignment_commit_link=' + assignment_commit_link + '&comment=' + comment + '&enrollment_id=' + enrollment_id.to_s, headers: {"content_type" => 'application/json',"authorization" => @auth_token})
  end
end

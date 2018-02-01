require 'httparty'
require 'json'

module Roadmap
  include HTTParty

  def get_roadmap(roadmap_id)
    response = self.class.get('/roadmaps/' + roadmap_id.to_s, headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get('/checkpoints/' + checkpoint_id.to_s, headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end
end

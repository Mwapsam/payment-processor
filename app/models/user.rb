class User < ApplicationRecord
    has_many :api_keys, as: :bearer
    
    has_secure_password

    self.primary_key = 'uuid'

    before_create :set_uuid
  
    private
  
    def set_uuid
      self.uuid = UUID.new.generate
    end  
end

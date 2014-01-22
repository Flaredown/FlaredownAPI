module TimeToMs
  module ClassMethods
    def from_ms(ms)
      at(ms/1000)
    end
  end
  
  module InstanceMethods
    def to_ms
      (self.to_f * 1000.0).to_i
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

class Time  
  include TimeToMs
end
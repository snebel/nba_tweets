class Team < ActiveRecord::Base
  serialize :handles, Array

 def to_param
  name
end
end

class Team < ActiveRecord::Base
  serialize :handles, Array

end

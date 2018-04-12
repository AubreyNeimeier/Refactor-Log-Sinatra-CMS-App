class Concern < ActiveRecord::Base
    belongs_to :project
    #the model with the belongs to association also has the foreign key
end

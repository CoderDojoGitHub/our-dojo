class Lesson < ActiveRecord::Base
  attr_accessible :repository, :summary, :title

  validates_presence_of :repository, :title
end

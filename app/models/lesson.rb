class Lesson < ActiveRecord::Base
  attr_accessible :repository, :summary, :title, :events

  validates_presence_of :repository, :title

  serialize :events
end

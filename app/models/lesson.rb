class Lesson < ActiveRecord::Base
  attr_accessible :events_attributes, :repository, :summary, :title

  has_many :events

  validates_presence_of :repository, :title

  serialize :events_attributes
end

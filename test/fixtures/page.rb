class Page < ActiveRecord::Base
  validates_length_of :title, :minimum => 2
  validates_presence_of :title
  acts_as_sluggable :source_column => :title, :slug_column => :slug,
    :scope => :parent, :slug_length => 50
end

class Subject < ActiveRecord::Base
  has_many  :questions
end

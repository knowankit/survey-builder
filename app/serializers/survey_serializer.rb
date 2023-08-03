class SurveySerializer < ActiveModel::Serializer
  attributes :id, :name, :permalink, :created_at, :updated_at, :is_published, :user_id

  has_many :questions
end

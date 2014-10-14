class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  # custom fields
  field :title,                 type: String,   default: ''
  field :description,           type: String,   default: ''
  field :completed,             type: Boolean,  default: false
  field :user_id,               type: Integer,  default: nil
  field :completed_at,          type: DateTime, default: DateTime.now
  field :created_at,            type: DateTime, default: DateTime.now
  field :updated_at,            type: DateTime, default: DateTime.now       
  
  
  ## Validations
  validates :title,   presence: true
  validates :user_id, presence: true
  validates :title,   uniqueness: true
  
  ## Associations
  belongs_to  :user
  
  def completed?
    completed
  end
  
end

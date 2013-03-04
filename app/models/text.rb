class Text < ActiveRecord::Base
  attr_accessible :locale, :text_content, :text_identifier, :textable_id, :textable_type
  
  belongs_to :textable, :polymorphic => true
  
  validates_presence_of :text_content, :text_identifier, :locale
end

class Endpoint < ApplicationRecord
  validates :verb, :path, :response, presence: true
  validates :path, uniqueness: { scope: :verb }
  validate :response_is_valid
  validate :check_path_url_is_valid

  before_save :downcase_fields

  def downcase_fields
    self.verb.upcase!
    self.path.downcase!
  end

  def check_path_url_is_valid
    if self.path =~ /[`=}{}><|]/ 
      self.errors.add(:path, "Invalid path url")
    end
  end

  def response_is_valid
    if !self.response.is_a?(Hash)
      self.errors.add(:response, "Invalid Response Data")
    else
      self.errors.add(:response, "code can't be blank") if self.response["code"].blank?
      self.errors.add(:response, "code value should be integer") if self.response["code"].present? && !self.response["code"].is_a?(Integer)
      self.errors.add(:response, "headers have invalid data") if self.response["headers"].present? && !self.response["headers"].is_a?(Hash)
    end
  end

end

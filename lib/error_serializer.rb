module ErrorSerializer
  def self.serialize(object)
    object.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          code: :unprocessable_entity,
          detail: "#{field.to_s.capitalize} #{error_message}"
        }
      end
    end.flatten
  end
end
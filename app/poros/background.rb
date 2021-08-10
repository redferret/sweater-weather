class Background
  alias read_attribute_for_serialization send
  attr_reader :image

  def initialize(attrs)
    @image = attrs[:image]
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end

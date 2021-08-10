require 'rails_helper'

RSpec.describe Background do
  describe 'instance,' do
    before :each do
      @image = {
        location: '',
        image_url: '',
        author: {
          portfolio_url: '',
          username: '',
          name: ''
        }
      }
      attrs = {
        image: @image
      }
      @background = Background.new(attrs)
    end

    it 'exists' do
      expect(@background).to be_a Background
    end

    it 'has expected attributes' do
      expect(@background).to have_attributes(image: @image)
      expect(@background.image).to have_key(:location)
      expect(@background.image).to have_key(:image_url)
      expect(@background.image).to have_key(:author)
      expect(@background.image[:author]).to have_key(:portfolio_url)
      expect(@background.image[:author]).to have_key(:username)
      expect(@background.image[:author]).to have_key(:name)
    end
  end

  describe 'class method,' do
    context '::model_name' do
      it 'returns the name of the model' do
        expect(Background.model_name).to eq 'Background'
      end
    end
  end
end

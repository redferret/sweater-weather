require 'rails_helper'

RSpec.describe BackgroundFacade, :vcr do
  describe 'class method,' do
    context '::search_backgrounds' do
      it 'returns a background poro' do
        background = BackgroundFacade.search_backgrounds('denver,co')

        expect(background).to be_a Background
        expect(background.image).to have_key(:location)
        expect(background.image).to have_key(:image_url)
        expect(background.image).to have_key(:author)
        expect(background.image[:author]).to have_key(:portfolio_url)
        expect(background.image[:author]).to have_key(:username)
        expect(background.image[:author]).to have_key(:name)
      end
    end
  end
end

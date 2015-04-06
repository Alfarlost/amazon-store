require 'rails_helper'

RSpec.describe Book, :type => :model do
  
  it { should validate_presence_of :price }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :bookinstock  }
  it { should have_many :orderitems }
  it { should have_many :ratings }
  it { should belong_to :author }
  it { should belong_to :category }

  it { is_expected.to callback(:set_small_description).before(:save) }

  context ".bestsellers" do
    let(:book) {FactoryGirl.create(:book)}
    let(:bestsellers) {FactoryGirl.create_list(:book_with_orderitems, 3)}
    
    it "returns book with orderitems" do
      expect(Book.bestsellers(3)).to match_array(bestsellers)
    end

    it "desn't return book without orderitems" do
      expect(Book.bestsellers(3)).not_to include(book)
    end
  end

  context ".set_small_description" do
    let(:book) {FactoryGirl.create(:book)}

    it "returns right small description" do
      book.send(:set_small_description)
      expect(book.small_description).to eq(book.description.first(150) + '...')
    end
  end

end

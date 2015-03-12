require 'spec_helper'

RSpec.describe Checkout do
  let(:order) { Order.create }
  let(:form) { described_class.new(order) }

  it "is invalid without attributes" do
    expect(form).to be_invalid
  end

  context "for addresses step" do
    before do
      form.attributes = { :form_step => "adresses", :b_adress => "a", :b_city => "a", :b_phone => "1", :b_country => "1", :b_zipcode => 12, :b_first_name => "1", :b_last_name => "1" }
    end
    
    context "with unchecked checkbox" do
      before do
        form.attributes = { :same_shipping_address => "false", :s_adress => "2", :s_city => "2", :s_phone => "2", :s_country => "2", :s_zipcode => 12, :s_first_name => "2", :s_last_name => "2" }
      end

      it "is valid with needed attributes" do
        expect(form).to be_valid 
      end

      it "updates billing_address with form params" do
        form.b_adress = "b"
        form.update(form.attributes)
        expect(order.billing_address.adress).to eq "b"
      end

      it "updates shipping_address with form params" do
        form.s_adress = "3"
        form.update(form.attributes)
        expect(order.shipping_address.adress).to eq "3"
      end
    end

    context "with checked checkbox" do
      before do
        form.same_shipping_address = "true"
      end

      it "is valid with only billing address" do
        expect(form).to be_valid 
      end

      it "updates billing_address with form params" do
        form.b_adress = "b"
        form.update(form.attributes)
        expect(order.billing_address.adress).to eq "b"
      end

      it "updates shipping_address with same attributes as billing_address" do
        form.b_adress = "b"
        form.update(form.attributes)
        expect(order.shipping_address.adress).to eq "b"
      end            
    end
  end

  context "validations for addresses step" do
    before do
      form.attributes = { :form_step => "payment", :number => "111", :cvv => "111", :expiration_month => 11, :expiration_year => 2017 }
    end

    it "is valid with needed attributes" do
      expect(form).to be_valid 
    end

    it "updates credit_card with form params" do
      form.expiration_month = 4
      form.update(form.attributes)
      expect(order.credit_card.expiration_month).to eq 4
    end
  end
end
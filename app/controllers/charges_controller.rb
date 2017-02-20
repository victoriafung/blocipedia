class ChargesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    if current_user
      @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Wikipedia Membership - #{current_user.name}",
        amount: 220
      }
    end
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 330,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.name}! Feel free to pay me again."
    current_user.role = 'premium'
    current_user.save!
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  # class Amount
  # #  def self.default
  # #    15_00
  # #  end
  # #
  #  def self.premium
  #    0_50
  #  end
  # end
end

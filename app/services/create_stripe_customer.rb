class CreateStripeCustomer
  def self.call(plan, email_address, token)

    user = User.find_by_email(email_address)
    plan = Plan.find_by_stripe_id(plan)

    subscription = Subscription.new(
      plan: plan,
      user: user
    )

    begin
      stripe_sub = nil

      binding.pry
      if user.stripe_customer_id.blank?
        customer = Stripe::Customer.create(
          source: token,
          email: user.email,
          plan: plan.stripe_id,
        )
        user.stripe_customer_id = customer.id
        user.save!
        stripe_sub = customer.subscriptions.first
      else
        customer = Stripe::Customer.retrieve(user.stripe_customer_id)
        stripe_sub = customer.subscriptions.create(
          plan: plan.stripe_id
        )
      end

      subscription.stripe_id = stripe_sub.id

      subscription.save!
    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
    end
  end
end

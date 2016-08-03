class CreatePlan
  def self.call(options={})

    begin
      plan = Stripe::Plan.retrieve(options[:stripe_id])
      plan.delete unless (plan.nil?)
    rescue Stripe::StripeError => e
    end

    plan = Plan.new(options)

    if !plan.valid?
      return plan
    end

    begin
      Stripe::Plan.create(
        id: options[:stripe_id],
        amount: options[:amount],
        currency: 'usd',
        interval: options[:interval],
        name: options[:name],
      )
    rescue Stripe::StripeError => e
      plan.errors[:base] << e.message

      return plan
    end

    plan.save

    return plan
  end
end

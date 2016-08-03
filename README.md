






# Service for creating new plan on Stripe Side and Server Side
CreatePlan.call(stripe_id: 'starter_plan', name: 'Starter Plan',
  amount: 0, interval: 'month',
  description: '<h4 class="text-center">Starter</h4><ul><li> FREE </li><li> Trial usage of our tools </li><li> Automated financial advice </li></ul>',
  published: true)

CreatePlan.call(stripe_id: 'premium_plan', name: 'Premium Plan',
  amount: 10000, interval: 'month',
  description: '<h4 class="text-center">Premium</h4><ul><li> $100.00 + monthly consultation fees </li><li> Unlimited use of all our software tools </li><li> 90-day money-back guarantee </li><li> Customized financial advice </li></ul>',
  published: true)

CreatePlan.call(stripe_id: 'gold_plan', name: 'Gold Plan',
  amount: 100000, interval: 'month',
  description: '<h4 class="text-center">Gold</h4><ul><li> $200.00 + monthly consultation fees </li><li> 90-day money-back guarantee </li><li> Personalized financial advice </li></ul>',
  published: true)

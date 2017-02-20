Rails.configuration.stripe = {
  publishable_key: 'pk_test_sN5e6NhyngzUlRvoj3DLe47p',
  secret_key: 'sk_test_BcIi2uN8yhy6aJVsKsg6T1MN'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

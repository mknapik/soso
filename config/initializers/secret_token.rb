# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Soso::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '72341680ab25a21025641b85e16f843510d11dac187803423c27528d755b91128b657bad7a5747aad1e322b6cbfd76ffd49512a2a90d0486431b57b5da7ad37'

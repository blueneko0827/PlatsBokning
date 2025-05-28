# Generate a new secret key
export SECRET_KEY_BASE=$(rails secret)

# Edit credentials (if needed)
rails credentials:edit --environment production
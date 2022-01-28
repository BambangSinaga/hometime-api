class ApplicationContract < Dry::Validation::Contract
  config.messages.load_paths += Dir[Rails.root.join('config', 'locales', 'contract', '*.{rb,yml}')]

  register_macro(:email_format) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure(:email_format)
    end
  end
end

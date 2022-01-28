module ManageHashIds
    def generate_hash(min_hash_length: 10)
      alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
      Hashids.new(Rails.application.secret_key_base, min_hash_length, alphabet)
    end
  end
end
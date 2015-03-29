module ApplicationHelper

  def hash
    @timestamp = "#{Time.now.to_i}"
    @private_key = ENV['MARVEL_PRIVATE_KEY']
    @public_key = ENV['MARVEL_PUBLIC_KEY']
    @hash = Digest::MD5.hexdigest("#{@timestamp}" + "#{@private_key}" + "#{@public_key}")
    @hash
  end

  def private_key
    @private_key = ENV['MARVEL_PRIVATE_KEY']
  end

  def public_key
    @public_key = ENV['MARVEL_PUBLIC_KEY']
  end

  def timestamp
    @timestamp = "#{Time.now.to_i}"
  end

end

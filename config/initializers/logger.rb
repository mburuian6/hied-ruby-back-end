Rails.logger = Logger.new($stdout, 'daily')
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"

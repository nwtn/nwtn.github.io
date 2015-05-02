class Jekyll::Converters::Markdown::Marktown
	def initialize(config)
		@config = config
		require 'uri'
		require 'net/http'
		require 'json'
	rescue LoadError
		STDERR.puts 'Herp derp'
		raise FatalException.new("Marktown couldn’t load")
	end

	def convert(content)
		@host = 'marktown.knowledgetranslation.ca'
		@port = '80'
		@post_ws = '/'

		@payload = {
			'body' => content
		}.to_json

		req = Net::HTTP::Post.new(@post_ws, initheader = {'Content-Type' => 'application/json'})
		req.body = @payload
		response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }
		response.body
	end
end

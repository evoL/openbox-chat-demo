module OpenTokSupport
  extend ActiveSupport::Concern

  class_methods do
    def opentok_client
      @opentok_client ||= OpenTok::OpenTok.new(
        ENV['TOKBOX_API_KEY'],
        ENV['TOKBOX_API_SECRET']
      )
    end
  end

  def opentok_client
    self.class.opentok_client
  end
end

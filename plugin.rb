# name: discourse-podcasts-onebox
# about: Support for embedding Podcsats widgets within Discourse
# version: 0.1
# authors: Renato Atilio
# url: https://github.com/renato/discourse-podcasts-onebox

class Onebox::Engine::SpreakerOnebox
  include Onebox::Engine
  include Onebox::Engine::StandardEmbed

  matches_regexp(/^https?:\/\/www\.spreaker\.com\/user\/.*\/.*$/)
  always_https

  def to_html
    get_oembed.html
  end
  
  def placeholder_html
    oembed = get_oembed
    return if Onebox::Helpers.blank?(oembed.thumbnail_url)
    "<img src='#{oembed.thumbnail_url}' #{oembed.title_attr}>"
  end

  private

  def get_oembed_url
    "https://api.spreaker.com/oembed?maxheight=200&url=#{url}"
  end
end
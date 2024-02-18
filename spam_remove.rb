#!/usr/bin/env ruby
# RAILS_ENVを設定
ENV['RAILS_ENV'] = 'production'
require_relative '/your/mastodon/live/config/environment'
#  メッセージ内に@マークが5個以上あるかをチェックするメソッド
def spam_detected?(message)
  message.scan(/@/).size >=  5
end

#  スパム検知を行うメソッド
def block_spam_messages
  #  全ての投稿を取得
  Status.all.each do |status|
    if spam_detected?(status.content)
      status.destroy
    end
  end
end

block_spam_messages




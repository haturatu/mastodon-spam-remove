# RAILS_ENVを設定
ENV['RAILS_ENV'] = 'production'
require_relative '/home/sns/mastodon/config/environment'

require 'uri'

# メッセージ内に@マークが5個以上あるかをチェックするメソッド
def spam_detected?(message)
  message.scan(/@/).size >= 5
end


def block_spam_messages
  spam_accounts = []
  #  全ての投稿を取得
  Status.all.each do |status|
    your_domain = 'eyes4you.org' # your_domain
    if spam_detected?(status.content)
      status.destroy
      if status.account.url
        domain = URI.parse(status.account.url).host
        spam_accounts << "#{status.account.username} (#{domain})"
      else
        spam_accounts << "#{status.account.username} (#{your_domain})"
      end
    end
  end
  #  スパムと判定されたアカウントをファイルに出力
  File.open('spam.txt', 'a') { |file| file.puts(spam_accounts) } unless spam_accounts.empty?
end

block_spam_messages


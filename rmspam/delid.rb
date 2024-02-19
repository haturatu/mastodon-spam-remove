#!/usr/bin/env ruby
# RAILS_ENVを設定
ENV['RAILS_ENV'] = 'production'
require_relative '/your/dir/mastodon/config/environment'

#  ユーザーIDによってアカウントを削除するメソッド
def delete_account_by_id(mastodon_id)
  # Mastodon IDからユーザー名を抽出
  username = mastodon_id.split('@')[0].delete('@')
  account = Account.find_by(username: username)
  if account
    account.delete
    puts "IDが#{mastodon_id}のアカウントを削除しました"
  else
    puts "IDが#{mastodon_id}のアカウントが見つかりませんでした"
  end
end

#  ユーザーIDの書かれたファイルを読み込む
file_path = 'tmp.txt'
File.readlines(file_path).each do |line|
  mastodon_id = line.strip
  delete_account_by_id(mastodon_id)
end


#!/bin/bash

# Mastodonユーザで実行してください
# rmspamディレクトリのフォルダの所有権限をmastodon:mastodonに変更してください
# spam_block.rbの17行目も変更してください
# delid.rbの4行目を変更してください。

# あなたのフォルダとドメインに変更
execdir=/your/dir/rmspam　
your_domain= 

echo "$your_domain"
$execdir/spam_block.rb
grep "$your_domain" spam.txt > delid.txt
sed -i "s/($your_domain)//g" delid.txt
sort delid.txt |  uniq > tmp.txt
$execdir/delid.rb

rm delid.txt spam.txt tmp.txt # SPAM IDのテキストファイルを残すならこの行をコメントアウトする

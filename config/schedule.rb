# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronログを吐き出す場所
set :output, "#{Rails.root}/log/cron.log"

# ジョブの実行環境の指定
set :environment, :development

# 1分毎に`HelloWorld`を出力する
every 1.minutes do
  rake 'auto_scraping:auto_scraping_task'
end
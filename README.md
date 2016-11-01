# dakoku-bot (打刻BOT)

King of time status notifier.

## how to use

```
git clone git@github.com:yo-iida/dakoku-bot.git
bundle install
```

make file `.env`

```
TARGET_URL=https://s3.kingtime.jp/admin?page_id=/timerecorder/daily_timerecord_list&account=xxxx&password=xxxx
TARGET_ROW=1
```

TARGET_URL: your king of time "出勤状況一覧" URL  
TARGET_ROW: row number to check

and execute this to notify.

```
bundle exec rake notifier
```

## cron example

dakoku-bot.sh
```
cd ~/repo/dakoku-bot
~/.rbenv/shims/bundle exec rake notifier
```

crontab
```
*/30 * * * * ~/script/dakoku-bot.sh
```

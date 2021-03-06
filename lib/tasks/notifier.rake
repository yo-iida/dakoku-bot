desc 'dakoku-notifier'
task :notifier do
  require 'mechanize'
  require 'terminal-notifier'

  today = Time.now.strftime('%Y%m%d')
  agent = Mechanize.new
  king_of_time = agent.get("#{ENV['TARGET_URL']}&selected_date=#{today}")
  target_row = ENV['TARGET_ROW'].to_i

  start_at = king_of_time.search('table')[1].search('tr')[target_row].search('td')[4].search('div').text.gsub(/\r\n|\s| /,'')
  end_at = king_of_time.search('table')[1].search('tr')[target_row].search('td')[5].search('div').text.gsub(/\r\n|\s| /,'')

  if start_at.empty?
    TerminalNotifier.notify('出勤時刻が打刻されていません', title: '打刻bot', sound: 'default', timeout: 5, group: 'dakoku-bot')
  end

  hour = Time.now.strftime('%H').to_i

  if end_at.empty? && hour > 19 && hour < 24
    TerminalNotifier.notify('退勤時刻が打刻されていません', title: '打刻bot', sound: 'default', timeout: 5, group: 'dakoku-bot')
  end
end

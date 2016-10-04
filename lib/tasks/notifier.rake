desc 'dakoku-notifier'
task :notifier do
  require 'mechanize'
  require 'terminal-notifier'
  today = Time.now.strftime('%Y%m%d')
  agent = Mechanize.new
  kingtime = agent.get("#{ENV['TARGET_URL']}&selected_date=#{today}")

  start_at = kingtime.search('table')[1].search('tr')[4].search('td')[4].search('div').text.gsub(/\r\n|\s| /,'')
  end_at = kingtime.search('table')[1].search('tr')[4].search('td')[5].search('div').text.gsub(/\r\n|\s| /,'')

  if start_at.empty?
    TerminalNotifier.notify('出勤時刻が打刻されていません', title: '打刻bot', sound: 'default', timeout: 5, group: 'dakoku-bot')
  end

  hour = Time.now.strftime('%H').to_i

  if end_at.empty? && hour > 19 && hour < 24
    TerminalNotifier.notify('退勤時刻が打刻されていません', title: '打刻bot', sound: 'default', timeout: 5, group: 'dakoku-bot')
  end
end

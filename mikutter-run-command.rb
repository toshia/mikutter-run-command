#-*- coding: utf-8 -*-

Plugin.create :run_com do

  command(:run_com,
          name: '指定コマンドの実行',
          condition: lambda{|opt| true},
          visible: false,
          role: :window) do |opt|
    Thread.new {
      #if UserConfig[:runcom] != NULL then
      if UserConfig[:runcom] != "" then
        system(UserConfig[:runcom])
      else
        ::Plugin.call(:update, nil, [Message.new(message: "コマンドが指定されていません", system: true)])
      end
    }
  end

  settings "コマンド実行" do
    settings "コマンドの指定" do
      input "command", :runcom
    end
  end
end

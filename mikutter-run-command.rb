#-*- coding: utf-8 -*-

Plugin.create :run_com do

  (UserConfig[:runcom]|| []).select{|m|!m.empty?}.each do |str|
    name="コマンド実行 #{str}"
    slug=":#{str}"
    command(slug.to_sym,
            name: name,
            condition: lambda{|opt| true},
            visible: false,
            role: :window) do |opt|
      Thread.new {
        system(str)
      }
    end
  end

  settings "コマンド実行" do
    settings "コマンドの指定" do
      multi "command", :runcom
    end
  end

end

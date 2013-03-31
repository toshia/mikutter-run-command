#-*- coding: utf-8 -*-

Plugin.create :run_com do

  def main
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
  end

#もっとスマートに書けるはず
#1秒毎に設定を確認してcommandに登録
  def sub
    old=(UserConfig[:runcom]|| []).select{|m|!m.empty?}
    Reserver.new(1){
      if (UserConfig[:runcom]|| []).select{|m|!m.empty?}!=old
        main
      end
      sub
    }
  end  

  main
  sub

  settings "コマンド実行" do
    settings "コマンドの指定" do
      multi "command", :runcom
    end
  end

end

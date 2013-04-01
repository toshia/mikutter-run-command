#-*- coding: utf-8 -*-

Plugin.create :run_com do

  filter_command do |menu|
    (UserConfig[:runcom]|| []).select{|m|!m.empty?}.each do |str|
      slug = ("runcom_" + str).to_sym
      menu[slug] = {
        slug: slug,
        name: "コマンド実行 #{str}",
        condition: lambda{|opt| true},
        visible: false,
        role: :window,
        exec: ->(opt){ bg_system(str) },
        plugin: @name}
    end
    [menu]
  end

  settings "コマンド実行" do
    settings "コマンドの指定" do
      multi "command", :runcom
    end
  end

end

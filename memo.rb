require "csv"

puts "1(新規でメモを作成) 2(既存のメモ編集する)"
input_val = gets.chomp
if input_val.to_i == 1 or input_val.to_i == 2 then
else 
  while input_val.to_i != 1 or input_val.to_i != 2 do
    puts "無効な入力です。"
    puts "1(新規でメモを作成) 2(既存のメモ編集する)"
    input_val = gets.chomp
    if input_val.to_i == 1 or input_val.to_i == 2 then
      break
    end
  end
end


input_mode = ''
if input_val.to_i == 1 then
  puts "拡張子を除いたファイルを入力してください"  
  input_file_name = gets.chomp
  target_file_name = input_file_name.to_str + '.csv'
  if File.exist?(target_file_name)
    puts "同じファイルが既にありますが、上書きしますか？追記しますか？"
    puts "w(上書き) a(追記)"
    input_mode = gets.chomp
    if input_mode == 'w' or input_mode == 'a' then
    else
      while input_mode != 'w' or input_mode != 'a' do
        puts "無効な入力です。"
        puts "w(上書き) a(追記)"
        input_mode = gets.chomp
        if input_mode == 'w' or input_mode == 'a' then
          break
        end
      end
    end
  else
    input_mode = 'w';
  end
else
  file_list = Dir.glob('*.csv')
  if file_list.count == 0 then
    input_mode = 'w'
    puts "拡張子を除いたファイルを入力してください（既存のファイルなし）"
    input_file_name = gets.chomp  
    target_file_name = input_file_name.to_str + '.csv'
  elsif file_list.count == 1 then
    input_mode = 'a'
    target_file_name = file_list[0]
  else
    input_mode = 'a'
    puts "================"
    puts "csvファイル候補"
    puts "----------------"
    puts file_list
    puts "================"
    puts "上記のファイル候補の中から、拡張子を除いたファイルを入力してください"
    input_file_name = gets.chomp  
    target_file_name = input_file_name.to_str + '.csv'
    if !File.exist?(target_file_name)
      while !File.exist?(target_file_name) do
        puts "そのファイルは、存在しません。"
        input_file_name = gets.chomp  
        target_file_name = input_file_name.to_str + '.csv'
      end
    end
  end
end


p "メモしたい内容を記入して下さい"
p "完了したら、Ctrl + Dをおします"
if input_mode == 'w' then
  input_str = STDIN.read.chomp
  CSV.open(target_file_name,'w') do |fp_00|
    fp_00.puts ["#{input_str}"]
  end
elsif input_mode == 'a' then
  base_str = CSV.readlines(target_file_name)
  puts "-----[前述]-----"
  puts base_str
  puts "-----[追記]-----"
  input_str = STDIN.read.chomp
  CSV.open(target_file_name,'a') do |fp_00|
    fp_00.puts ["#{input_str}"]
  end
end

require 'nword_text_search/version'

# Nword Text Search Module
module NwordTextSearch
  def self.show_header
    system 'clear' unless system 'cls'
    puts '-------------------------------------------------------------------------------------'
    puts 'NWORD TEXT SEARCH!'
    puts '-------------------------------------------------------------------------------------'
    puts 'AUTHOR:   Levon Becker'
    puts "VERSION:  #{@vgver} - #{@vgdate}"
    puts 'PURPOSE:  Search for 2 words in text files that are n words apart.'
    puts '-------------------------------------------------------------------------------------'
  end

  def self.show_sub_header(subtext)
    puts subtext
    puts '-------------------------------------------------------------------------------------'
    puts ''
  end

  def self.fetch_file_list
    @text_file_list = Array.new
    @text_file_list = Dir.glob("#{@search_path}/*.txt")
  end

  def self.search_files(search_word_one, search_word_two, max_word_separation)
    fetch_file_list
    match_list = Array.new
    @text_file_list.each do |text_file|
      content = File.read(text_file).downcase
      if content.include?(search_word_one.downcase) && content.include?(search_word_two.downcase)
        puts "Both Words Found in #{text_file}"
        split_content = content.split
        # nwords = content[/#{search_word_one}(.*?)#{search_word_two}/, 1].split.count
        content_map = split_content.map.with_index.to_a

        word_list_one = Array.new
        word_list_second = Array.new
        content_map.each do |word|
          word_list_one << word[1] if word.include?(search_word_one)
          word_list_second << word[1] if word.include?(search_word_two)
        end

        unless word_list_one.empty? && word_list_second.empty?
          word_list_one.each do |num1|
            word_list_second.each do |num2|
              diff = num1 - num2
              match_list << text_file if diff <= max_word_separation
            end
          end
        end
      else
        puts "Both Words Not Found in #{text_file}"
      end
    end
    match_list.uniq
  end

  def self.fetch_current_path
    @search_path = File.dirname(__FILE__)
  end

  # Console Run Method
  def self.run
    require 'highline/import'
    @vgver  = '1.0.0'
    @vgdate = '07/29/2015'

    # Prompt for Search Path
    show_header
    show_sub_header('ENTER SEARCH PATH')
    # TODO: Remove trailing path if there
    begin
      choose do |menu|
        # menu.layout = :menu_only
        # menu.header = 'Enter Search Path'
        menu.prompt  =  '> '
        menu.choice('Current Directory') { fetch_current_path }
        menu.choice('Enter Path') { @search_path = gets.chomp }
        menu.choice(:Quit, 'Exit program.') { exit }
      end
    end

    # TODO: Make a prompt symbol show up for chomps
    # Prompt for First Search Word
    show_header
    show_sub_header('ENTER FIRST SEARCH WORD')
    search_word_one = gets.chomp

    # Prompt for Second Search Word
    show_header
    show_sub_header('ENTER SECOND SEARCH WORD')
    search_word_two = gets.chomp

    # Prompt for Second Search Word
    show_header
    show_sub_header('ENTER N WORD SEPARATION')
    max_word_separation = gets.chomp.to_i

    # Run Search
    match_list = search_files(search_word_one, search_word_two, max_word_separation)

    # Results
    show_header
    show_sub_header('RESULTS')
    puts "SEARCH PATH:         (#{@search_path})"
    puts "FIRST WORD:          (#{search_word_one})"
    puts "SECOND WORD:         (#{search_word_two})"
    puts "MAX WORD SEPARATION: (#{max_word_separation})"
    puts ''
    if @text_file_list.empty?
      puts 'NO *.TXT FILES FOUND!'
    else
      puts 'FILES SEARCHED:'
      puts '-------------------------'
      @text_file_list.each do |searched|
        puts searched
      end
    end
    puts ''
    if match_list.empty?
      puts 'NOT MATCHES FOUND!'
    else
      puts 'FILES THAT MATCH SEARCH:'
      puts '-------------------------'
      match_list.each do |match|
        puts match
      end
    end
  end
end

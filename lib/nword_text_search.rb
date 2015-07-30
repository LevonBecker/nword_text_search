require 'nword_text_search/version'

# Nword Text Search Module
module NwordTextSearch
  require 'readline'

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
    @text_file_list = Dir.glob("#{@search_path}/*.txt")
  end

  def self.word_search(content_map)
    @word_list_one = Array.new
    @word_list_two = Array.new
    content_map.each do |word|
      @word_list_one << word[1] if word.include?(@search_word_one)
      @word_list_two << word[1] if word.include?(@search_word_two)
    end
  end

  def self.process_file(text_file)
    unless @word_list_one.empty? && @word_list_two.empty?
      @word_list_one.each do |num1|
        @word_list_two.each do |num2|
          diff = num1 - num2
          @match_list << text_file if diff <= @n_words
        end
      end
    end
    @match_list = @match_list.uniq
  end

  def self.read_file(text_file)
    File.read(text_file).downcase
  end

  def self.search_files
    NwordTextSearch.fetch_file_list
    @match_list = Array.new
    @text_file_list.each do |text_file|
      content = NwordTextSearch.read_file(text_file)
      if content.include?(@search_word_one.downcase) && content.include?(@search_word_two.downcase)
        puts "Both Words Found in #{text_file}"
        NwordTextSearch.word_search(content.split.map.with_index.to_a)
        NwordTextSearch.process_file(text_file)
      else
        puts "Both Words Not Found in #{text_file}"
      end
    end
  end

  def self.fetch_current_path
    require 'fileutils'
    FileUtils.pwd
  end

  def self.prompt_path
    require 'highline/import'
    show_header
    show_sub_header('ENTER SEARCH PATH')
    # TODO: Remove trailing path if there
    begin
      choose do |menu|
        # menu.layout = :menu_only
        # menu.header = 'Enter Search Path'
        menu.prompt  =  '> '
        menu.choice('Current Directory') {
          @search_path = NwordTextSearch.fetch_current_path
        }
        menu.choice('Enter Path') {
          show_header
          show_sub_header('ENTER SEARCH PATH')
          @search_path = Readline.readline('Search Path >> ')
        }
        menu.choice(:Quit, 'Exit program.') { exit }
      end
    end
  end

  def self.prompt_word_one
    # TODO: Make a prompt symbol show up for chomps
    show_header
    show_sub_header('ENTER FIRST SEARCH WORD')
    @search_word_one = Readline.readline('First Word >> ')
  end

  def self.prompt_word_two
    show_header
    show_sub_header('ENTER SECOND SEARCH WORD')
    @search_word_two = Readline.readline('Second Word >> ')
  end

  def self.prompt_n_words
    show_header
    show_sub_header('ENTER N WORDS SEPARATION')
    @n_words = Readline.readline('N Words >> ').to_i
  end

  def self.results_files_searched
    if @text_file_list.empty?
      puts 'NO *.TXT FILES FOUND!'
    else
      puts 'FILES SEARCHED:'
      puts '-------------------------'
      @text_file_list.each do |searched|
        puts searched
      end
    end
  end

  def self.results_files_matched
    if @match_list.empty?
      puts 'NOT MATCHES FOUND!'
    else
      puts 'FILES THAT MATCH SEARCH:'
      puts '-------------------------'
      @match_list.each do |match|
        puts match
      end
    end
  end

  def self.display_results
    show_header
    show_sub_header('RESULTS')
    puts "SEARCH PATH:   (#{@search_path})"
    puts "FIRST WORD:    (#{@search_word_one})"
    puts "SECOND WORD:   (#{@search_word_two})"
    puts "N WORDS:       (#{@n_words})"
    puts ''
    NwordTextSearch.results_files_searched
    puts ''
    NwordTextSearch.results_files_matched
  end

  # Console Run Method
  def self.run
    @vgver  = '1.0.0'
    @vgdate = '07/29/2015'

    # Prompt for Search Path
    NwordTextSearch.prompt_path

    # Prompt for First Search Word
    NwordTextSearch.prompt_word_one

    # Prompt for Second Search Word
    NwordTextSearch.prompt_word_two

    # Prompt for N Words
    NwordTextSearch.prompt_n_words

    # Run Search
    NwordTextSearch.search_files

    # Results
    NwordTextSearch.display_results
  end
end

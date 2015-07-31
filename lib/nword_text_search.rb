# require 'nword_text_search/version'

# Nword Text Search Module
module NwordTextSearch
  # Console User Interface Class
  class UI
    # Header Class
    class Header
      def initialize
        # Instance Variables
        @vgver  = '1.1.0'
        @vgdate = '07/31/2015'
      end

      def show_header
        system 'clear' unless system 'cls'
        puts '-------------------------------------------------------------------------------------'
        puts 'NWORD TEXT SEARCH!'
        puts '-------------------------------------------------------------------------------------'
        puts 'AUTHOR:   Levon Becker'
        puts "VERSION:  #{@vgver} - #{@vgdate}"
        puts 'PURPOSE:  Search for 2 words in text files that are n words apart.'
        puts '-------------------------------------------------------------------------------------'
      end

      def show_sub_header(subtext)
        puts subtext
        puts '-------------------------------------------------------------------------------------'
        puts ''
      end
    end

    # Results Class
    class Results
      def initialize(search_results, prompts)
        @header = NwordTextSearch::UI::Header.new
        @search_results = search_results
        @prompts = prompts
      end

      def results_files_searched
        if @search_results.text_file_list.empty?
          puts 'NO *.TXT FILES FOUND!'
        else
          puts 'FILES SEARCHED:'
          puts '-------------------------'
          @search_results.text_file_list.each do |searched|
            puts searched
          end
        end
      end

      def results_files_matched
        if @search_results.match_list.empty?
          puts 'NOT MATCHES FOUND!'
        else
          puts 'FILES THAT MATCH SEARCH:'
          puts '-------------------------'
          @search_results.match_list.each do |match|
            puts match
          end
        end
      end

      def display_results
        @header.show_header
        @header.show_sub_header('RESULTS')
        puts "SEARCH PATH:   (#{@prompts.search_path})"
        puts "FIRST WORD:    (#{@prompts.search_word_one})"
        puts "SECOND WORD:   (#{@prompts.search_word_two})"
        puts "N WORDS:       (#{@prompts.n_words})"
        puts ''
        results_files_searched
        puts ''
        results_files_matched
      end
    end

    # Prompts Class
    class Prompts
      require 'highline/import'
      require 'readline'
      require 'fileutils'
      attr_reader :search_path
      attr_reader :search_word_one
      attr_reader :search_word_two
      attr_reader :n_words

      def initialize
        # Instance Variables
        @header = NwordTextSearch::UI::Header.new
        prompt_path
        prompt_word_one
        prompt_word_two
        prompt_n_words
      end

      def fetch_current_path
        FileUtils.pwd
      end

      def prompt_path
        @header.show_header
        @header.show_sub_header('SELECT SEARCH INPUT OPTION')
        # TODO: Remove trailing path if there?
        begin
          choose do |menu|
            # menu.layout = :menu_only
            # menu.header = 'Enter Search Path'
            menu.prompt  =  '> '
            menu.choice('Current Directory') do
              @search_path = fetch_current_path
            end
            menu.choice('Enter Path') do
              @header.show_header
              @header.show_sub_header('ENTER SEARCH PATH')
              @search_path = Readline.readline('Search Path >> ').to_s
            end
            menu.choice(:Quit, 'Exit program.') { exit }
          end
        end
      end

      def prompt_word_one
        @header.show_header
        @header.show_sub_header('ENTER FIRST SEARCH WORD')
        @search_word_one = Readline.readline('First Word >> ').to_s
      end

      def prompt_word_two
        @header.show_header
        @header.show_sub_header('ENTER SECOND SEARCH WORD')
        @search_word_two = Readline.readline('Second Word >> ').to_s
      end

      def prompt_n_words
        @header.show_header
        @header.show_sub_header('ENTER N WORDS SEPARATION')
        @n_words = Readline.readline('N Words >> ').to_i
      end
    end
  end

  # Search Class
  class Search
    attr_reader :text_file_list
    attr_reader :match_list

    def initialize(search_path, search_word_one, search_word_two, n_words)
      # Instance Variables
      @search_path = search_path
      @search_word_one = search_word_one
      @search_word_two = search_word_two
      @n_words = n_words
      @text_file_list = Array.new
      @match_list = Array.new
      fetch_file_list
      find_matches
    end

    def fetch_file_list
      @text_file_list = Dir.glob("#{@search_path}/*.txt")
    end

    def word_search(content_map)
      @word_list_one = Array.new
      @word_list_two = Array.new
      content_map.each do |word|
        @word_list_one << word[1] if word.include?(@search_word_one)
        @word_list_two << word[1] if word.include?(@search_word_two)
      end
    end

    def process_file(text_file)
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

    def read_file(text_file)
      File.read(text_file).downcase
    end

    def find_matches
      @text_file_list.each do |text_file|
        content = read_file(text_file)
        if content.include?(@search_word_one.downcase) && content.include?(@search_word_two.downcase)
          word_search(content.split.map.with_index.to_a)
          process_file(text_file)
        end
      end
    end
  end

  # Console Run Method
  def self.run
    def self.run_search(prompts)
      # Run Search
      NwordTextSearch::Search.new(
        prompts.search_path,
        prompts.search_word_one,
        prompts.search_word_two,
        prompts.n_words
      )
    end

    # Prompt and Search
    prompts = NwordTextSearch::UI::Prompts.new
    search_results = run_search(prompts)

    # Results
    NwordTextSearch::UI::Results.new(search_results, prompts).display_results
  end
end

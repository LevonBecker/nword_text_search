require 'text_search/version'

module NwordTextSearch
  def run
    require 'highline/import'
    @vgver  = '1.0.0'
    @vgdate = '07/29/2015'


    def show_header
      system 'clear' unless system 'cls'
      puts '-------------------------------------------------------------------------------------'
      puts 'TEXT SEARCH!'
      puts '-------------------------------------------------------------------------------------'
      puts 'AUTHOR:   Levon Becker'
      puts "VERSION:  #{@vgver} - #{@vgdate}"
      puts 'PURPOSE:  Search for two words in all text documents in a directory.'
      puts '-------------------------------------------------------------------------------------'
    end

    def show_subheader(subtext)
      puts subtext
      puts '-------------------------------------------------------------------------------------'
      puts ''
    end

    def search_files(search_path, search_word_one, search_word_two, number_of_words_apart)
      match_list = Array.new
      text_file_list = Dir.glob("#{search_path}/*.txt")
      text_file_list.each do |text_file|
        content = File.read(text_file).downcase
        if content.include?(search_word_one.downcase) && content.include?(search_word_two.downcase)
          puts "Both Words Found in #{text_file}"
          split_content = content.split
          # nwords = content[/#{search_word_one}(.*?)#{search_word_two}/, 1].split.count
          content_map = split_content.map.with_index.to_a

          word_list_one = Array.new
          word_list_second = Array.new
          content_map.each do |word|
            if word.include?(search_word_one)
              word_list_one << word[1]
            end
            if word.include?(search_word_two)
              word_list_second << word[1]
            end
          end

          unless word_list_one.empty? && word_list_second.empty?
            word_list_one.each do |num1|
              word_list_second.each do |num2|
                diff = num1 - num2
                if diff <= number_of_words_apart
                  match_list << text_file
                end
              end
            end
          end
        else
          puts "Both Words Not Found in #{text_file}"
        end
        puts "Both Words Found (#{number_of_words_apart}) Apart:/n/n #{match_list.uniq.flatten.join(', ')}"
      end
    end

    def get_current_path
      @search_path = File.dirname(__FILE__)
    end

    # User Variables
    # search_path = '/Users/levon/Development/github/stelligent/levons_program_exercise/ruby/text_search/test'
    # search_word_one = 'the'
    # search_word_two = 'wilson'
    # number_of_words_apart = 5  # Expect Integer

    # Prompt for Search Path
    show_header
    show_subheader('ENTER SEARCH PATH')
    begin
      choose do |menu|
        #menu.layout = :menu_only
        #menu.header = 'Operating System Selection'
        menu.prompt  =  '> '
        menu.choice(:Current_Directory) { get_current_path }
        menu.choice(:Enter_Path) { @search_path = gets.chomp }
        menu.choice(:Quit, 'Exit program.') { exit }
      end
    end

    # Prompt for First Search Word
    show_header
    show_subheader('ENTER FIRST SEARCH WORD')
    search_word_one = gets.chomp

    # Prompt for Second Search Word
    show_header
    show_subheader('ENTER SECOND SEARCH WORD')
    search_word_second = gets.chomp

    # Prompt for Second Search Word
    show_header
    show_subheader('ENTER N WORD SEPARATION')
    number_of_words_apart = gets.chomp.to_i

    # Run Search
    search_files(search_path, search_word_one, search_word_two, number_of_words_apart)
  end
end

# NwordTextSearch

Search a directory of text files for two words separated by n words.

## Compile

```ruby
gem build nword_text_search.gemspec
```

## Install Gem

```ruby
gem install nword_text_search-1.0.0.gem
```

## Usage

nword_text_search

## Shell Script

I added a simple shell script in the root directory that will compile, install and run the Rubygem.

### System Ruby

```bash
rm -f *.gem
gem build nword_text_search.gemspec
gem install nword_text_search-*.gem
nword_text_search
```

### ChefDK Ruby

```bash
rm -f *.gem
chef exec gem build nword_text_search.gemspec
chef exec gem install nword_text_search-*.gem
chef exec nword_text_search
```

## Examples

Using the test files in the test directory.

```
cd /path/to/nword_text_search
. /build_install_run_chefdk.sh
```

    -------------------------------------------------------------------------------------
    NWORD TEXT SEARCH!
    -------------------------------------------------------------------------------------
    AUTHOR:   Levon Becker
    VERSION:  1.1.0 - 07/31/2015
    PURPOSE:  Search for 2 words in text files that are n words apart.
    -------------------------------------------------------------------------------------
    SELECT SEARCH INPUT OPTION
    -------------------------------------------------------------------------------------
    
    1. Current Directory
    2. Enter Path
    3. Quit
    > 2

    -------------------------------------------------------------------------------------
    NWORD TEXT SEARCH!
    -------------------------------------------------------------------------------------
    AUTHOR:   Levon Becker
    VERSION:  1.1.0 - 07/31/2015
    PURPOSE:  Search for 2 words in text files that are n words apart.
    -------------------------------------------------------------------------------------
    ENTER SEARCH PATH
    -------------------------------------------------------------------------------------
    
    Search Path >> /Users/levon/Development/github/levonbecker/nword_text_search/test

    -------------------------------------------------------------------------------------
    NWORD TEXT SEARCH!
    -------------------------------------------------------------------------------------
    AUTHOR:   Levon Becker
    VERSION:  1.1.0 - 07/31/2015
    PURPOSE:  Search for 2 words in text files that are n words apart.
    -------------------------------------------------------------------------------------
    ENTER FIRST SEARCH WORD
    -------------------------------------------------------------------------------------
    
    First Word >> the

    -------------------------------------------------------------------------------------
    NWORD TEXT SEARCH!
    -------------------------------------------------------------------------------------
    AUTHOR:   Levon Becker
    VERSION:  1.1.0 - 07/31/2015
    PURPOSE:  Search for 2 words in text files that are n words apart.
    -------------------------------------------------------------------------------------
    ENTER SECOND SEARCH WORD
    -------------------------------------------------------------------------------------
    
    Second Word >> wilson

    -------------------------------------------------------------------------------------
    NWORD TEXT SEARCH!
    -------------------------------------------------------------------------------------
    AUTHOR:   Levon Becker
    VERSION:  1.1.0 - 07/31/2015
    PURPOSE:  Search for 2 words in text files that are n words apart.
    -------------------------------------------------------------------------------------
    ENTER N WORDS SEPARATION
    -------------------------------------------------------------------------------------
    
    N Words >> 5

    -------------------------------------------------------------------------------------
    NWORD TEXT SEARCH!
    -------------------------------------------------------------------------------------
    AUTHOR:   Levon Becker
    VERSION:  1.1.0 - 07/31/2015
    PURPOSE:  Search for 2 words in text files that are n words apart.
    -------------------------------------------------------------------------------------
    RESULTS
    -------------------------------------------------------------------------------------
    
    SEARCH PATH:   (/Users/levon/Development/github/levonbecker/nword_text_search/test)
    FIRST WORD:    (the)
    SECOND WORD:   (wilson)
    N WORDS:       (5)
    
    FILES SEARCHED:
    -------------------------
    /Users/levon/Development/github/levonbecker/nword_text_search/test/test01.txt
    /Users/levon/Development/github/levonbecker/nword_text_search/test/test02.txt
    /Users/levon/Development/github/levonbecker/nword_text_search/test/test03.txt
    
    FILES THAT MATCH SEARCH:
    -------------------------
    /Users/levon/Development/github/levonbecker/nword_text_search/test/test01.txt
    /Users/levon/Development/github/levonbecker/nword_text_search/test/test02.txt

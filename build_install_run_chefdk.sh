#!/usr/bin/env bash

rm -f *.gem
chef exec gem build nword_text_search.gemspec
chef exec gem install nword_text_search-*.gem
chef exec nword_text_search

#!/usr/bin/env bash

rm -f *.gem
gem build nword_text_search.gemspec
gem install nword_text_search-*.gem
nword_text_search

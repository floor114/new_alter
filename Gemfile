source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

#=== CORE ======================================================================
gem 'rails',                                                          '~> 5.0.0'
gem 'puma',                                                            '~> 3.11'
gem 'pg',                                                              '~> 0.18'

#=== UI ========================================================================
gem 'sass-rails',                                                       '~> 5.0'
gem 'uglifier',                                                       '>= 1.3.0'
gem 'coffee-rails',                                                     '~> 4.2'
gem 'turbolinks',                                                         '~> 5'
gem 'jbuilder',                                                         '~> 2.5'
gem 'bootsnap',                                       '>= 1.1.0', require: false
gem 'bootstrap-sass',                                                 '~> 3.3.7'
gem 'haml-rails'
gem 'high_voltage'
gem 'jquery-rails'
gem 'therubyracer'
gem 'font-awesome-rails'
gem 'sprockets',                                                '>= 4.0.0.beta7'
#TODO: remove after adding webpacker
gem 'sprockets-es6'
gem 'select2-rails'

#=== CONFIG ====================================================================
gem 'dotenv-rails',                                                     '~> 2.2'
gem 'tzinfo-data',               platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#=== TRAILBLAZER ===============================================================
gem 'trailblazer'
gem 'trailblazer-rails'
gem 'trailblazer-cells'
gem 'trailblazer-finder'
gem 'cells-haml'
gem 'cells-rails'

#=== AUTHENTICATION & AUTHORIZATION ============================================
gem 'devise'
gem 'pundit'

#=== FEATURES ==================================================================
gem 'paperclip',                                                      '~> 6.0.0'
gem 'aws-sdk-s3',                                                         '~> 1'
gem 'cocoon'
gem 'administrate',                              github: 'floor114/administrate'
gem 'faker'
gem 'rails-i18n'
gem 'impressionist'
gem 'public_activity'

#=== DEV & TEST ================================================================
group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'awesome_print'
  gem 'html2haml'
end

group :development, :test do
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'codecov', :require => false
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end

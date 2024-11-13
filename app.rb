require 'rouge'
require 'sinatra'

THEMES = [
  Rouge::Themes::Base16,
  Rouge::Themes::BlackWhiteTheme,
  Rouge::Themes::Colorful,
  Rouge::Themes::Github,
  Rouge::Themes::Gruvbox,
  Rouge::Themes::IgorPro,
  Rouge::Themes::Magritte,
  Rouge::Themes::Molokai,
  Rouge::Themes::Monokai,
  Rouge::Themes::MonokaiSublime,
  Rouge::Themes::Pastie,
  Rouge::Themes::ThankfulEyes,
  Rouge::Themes::Tulip
].freeze

LANGS = Rouge::Lexer.all.sort_by(&:tag).map do |lexer|
  [lexer.respond_to?(:title) ? lexer.title : lexer.tag, lexer.tag]
end

get '/' do
  @bgcolor = '#000000'
  erb :index
end

post '/' do
  @theme = Object.const_get(params['theme'])
  @language = params['language']
  @code = params['code']
  @bgcolor = params['bgcolor']
  formatter = Rouge::Formatters::HTMLInline.new(@theme)
  lexer = Rouge::Lexer.find(@language)
  @parsed_code = formatter.format(lexer.lex(@code))
  erb :index
end

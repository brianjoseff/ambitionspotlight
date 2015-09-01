FactoryGirl.define do
  factory :post do
  end
end

def linkify_mentions_hashtags_bangbangs(text)
  text.gsub!(/@([\w]+)(\W)?/, '<a href="/\1" class="pretty-link mention-pretty-link">@\1</a>\2')
  text.gsub!(/#([\w]+)(\W)?/, '<a href="/search?q=%23\1" class="pretty-link tag-pretty-link">#\1</a>\2')
  text.gsub!(/!!([\w]+)(\W)?/, '<a href="/search?q=%21%21\1" class="pretty-link bangbang-pretty-link">!!\1</a>\2')
  text
end

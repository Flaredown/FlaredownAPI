class HashtagParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      hashtag_regex = /\B#(\w+)/
      tag_list.add @tag_list.scan(hashtag_regex).flatten
    end
  end
end
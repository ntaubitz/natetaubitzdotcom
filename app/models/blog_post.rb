require 'github/markup'

class BlogPost < ApplicationRecord
  CATEGORIES = {
    software_development: 'software_development',
    family: 'family',
    health: 'health',
    jeeps: 'jeeps'
  }.freeze

  validates :subject, :presence => true
  validates :markup, :presence => true
  validates :user_id, :presence => true

  belongs_to :user

  scope :most_recent, -> () {order(created_at: :desc).limit(10)}
  scope :published, -> (published) {where(published: published)}
  scope :for_category, -> (category) {where(category: category)}

  enum category: CATEGORIES

  # get an introduction or shortened blog post
  def short_markup
    if markup.length > 812
      index = 0
      lines_included = 0
      while lines_included < 5 && !index.nil?
        test_index = markup.index "\n", index + 1
        if test_index.nil?
          break
        end
        index = test_index
        lines_included += 1
      end
      if index > 812
        index = 812
      end
      return markup[0..index]
    end
    markup
  end

  def short_markup_for_display
    to_html short_markup
  end

  def markup_for_display
    to_html markup
  end

  private

  def to_html(markdown)
    GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, markdown)
  end
end
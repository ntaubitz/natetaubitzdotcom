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
      # remove all the body children tags except the first p tag
      doc = Nokogiri::HTML.fragment(markup)
      first_p = nil
      doc.children.each do |child|
        if child.name == 'p'
          unless first_p.nil?
            child.remove
          else
            first_p = child
          end
        end
      end

      # if that one tag is too long, truncate the text
      if doc.to_html.length > 812
        first_p.content = first_p.text[0..809] + '...'
      end
      return doc.to_html
    end
    markup
  end

  def markup_for_display
    doc = Nokogiri::HTML.fragment(markup)
    encode_fragment doc
    doc.to_html
  end

  def encode_fragment(doc)
    doc.children.each do |child|
      if child.name.to_sym == :code
        child.inner_html = CGI::escapeHTML child.inner_html
      else
        encode_fragment(child)
      end
    end
  end
end
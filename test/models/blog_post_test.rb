require File.expand_path('../../test_helper', __FILE__)

class BlogPostTest < ActiveSupport::TestCase
  test 'a short blog post is not truncated' do
    short_blog = blog_posts(:short)
    assert "# short post\nwith a paragraph" == short_blog.short_markup
    assert "<h1>short post</h1>\n<p>with a paragraph</p>\n" == short_blog.short_markup_for_display
  end

  test 'a long blog post with multiple tags has just the first tag' do
    long_blog = blog_posts(:long_multiple_tags)
    assert "<h1>long post</h1>\n<p>truncate me.\ntruncate me.\ntruncate me.\ntruncate me.</p>\n" == long_blog.short_markup_for_display
  end

  test 'a long blog post with one long tag has truncated text' do
    long_blog = blog_posts(:long_one_tag)
    s = long_blog.short_markup_for_display
    assert 828 == s.length
  end

  test 'code blocks are html encoded for display in a web page' do
    post = blog_posts(:encoded_code_tag)
    assert "<p>encoded\n<code>{a:12}</code></p>\n" == post.markup_for_display
  end
end

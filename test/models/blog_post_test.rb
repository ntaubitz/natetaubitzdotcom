require File.expand_path('../../test_helper', __FILE__)

class BlogPostTest < ActiveSupport::TestCase
  test 'a short blog post is not truncated' do
    short_blog = blog_posts(:short)
    assert 39 == short_blog.short_markup.length
  end

  test 'a long blog post with multiple tags has just the first tag' do
    long_blog = blog_posts(:long_multiple_tags)
    assert "<h1>long post</h1><p>truncate me. </p>" == long_blog.short_markup
  end

  test 'a long blog post with one long tag has truncated text' do
    long_blog = blog_posts(:long_one_tag)
    assert 838 == long_blog.short_markup.length
  end

  test 'code blocks are html encoded for display in a web page' do
    post = blog_posts(:encoded_code_tag)
    assert '<p>encoded</p><div><div><pre><code>&lt;div&gt;foo&lt;/div&gt;</code></pre></div></div>' == post.markup_for_display
  end
end

class ShortPostsController < ApplicationController
  before_action :set_post, only: [:show, :update]

  # GET /short_posts
  def index
    # after building a query above, use the scopes we have available to further constrain the result set
    # has_scope/apply_scopes come from has_scope gem
    paginate(apply_scopes(current_user.short_posts))
  end
end

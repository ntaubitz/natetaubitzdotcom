class ApplicationController < ActionController::Base
  include Authentication

  helper_method :current_user, :anonymous_user, :host_url

  def paginate(things, serializer=nil)
    page = params.fetch(:page, 1).to_i
    results_per_page = params.fetch(:results_per_page, 10).to_i
    order_by = params.fetch(:order_by, 'id').to_s
    direction = params.fetch(:direction, '').to_s

    data = {
      :page => page,
      :total_results => things.count,
      :objects => []
    }
    data[:total_pages] = (data[:total_results].to_f / results_per_page.to_f).ceil

    offset = (page - 1) * results_per_page

    query = things
              .offset(offset)
              .limit(results_per_page)
    query = query.order("#{order_by} #{direction.blank? ? 'desc' : direction}")

    options = {}
    options[:serializer] = serializer unless serializer.nil?
    query.each do |thing|
      data[:objects] << ActiveModelSerializers::SerializableResource.new(thing, options).as_json
    end

    data[:num_results] = data[:objects].count

    render json: data
  end

  def host_url
    Natetaubitzdotcom::Application.config.host_url
  end

end

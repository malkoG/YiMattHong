# frozen_string_literal: true

class NoticeFinder
  def klass
    Board
  end

  def aggregation
    klass.includes(:notices).find(@params[:id]).notices
  end

  def initialize(params)
    @params = params
  end

  def execute
    query = aggregation
      .order('published_at desc')
      .page(@params[:page])

    if @params[:q].present?
      query = query.search_by_keyword(@params[:q])
    end

    query
  end
end

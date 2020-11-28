# frozen_string_literal: true

class BoardsController < ApplicationController
  def show
    @notices = Board
      .includes(:notices)
      .find(params[:id])
      .notices
      .order('published_at desc')
  end

  def subscribe
    return :unauthorized unless current_user.present?

    if current_user.subscriptions.find_or_create_by(board_id: params[:id])
      flash[:notice] = '즐겨찾기에 추가 완료했습니다.'
    else
      flash[:error] = '해당 게시판을 찾을 수 없습니다.'
    end

    redirect_to curations_path
  end

  def unsubscribe
    return :unauthorized unless current_user.present?

    subscription = Subscription.find_by(board_id: params[:id])
    if subscription.present?
      subscription.destroy!
      flash[:notice] = '즐겨찾기에서 제거했습니다.'
    else
      flash[:notice] = '해당 게시판을 찾을 수 없습니다.'
    end

    redirect_to curations_path
  end
end

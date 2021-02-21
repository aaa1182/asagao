class MembersController < ApplicationController
  before_action :login_required

  # 会員一覧
  def index
    @members = Member.order('number').page(params[:page]).per(15)
  end

  # 検索
  def search
    @members = Member.search(pamams[:q]).page(params[:page]).per(15)
    render :index
  end

  # 詳細
  def show
    @member = Member.find(params[:id])
  end

end

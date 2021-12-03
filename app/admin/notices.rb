ActiveAdmin.register Notice do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :author, :published_at, :content, :bbs_pk, :post_pk, :attachments, :board_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :author, :published_at, :content, :bbs_pk, :post_pk, :attachments, :board_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    id_column
    column("게시판") { |notice| link_to(notice.board.category, admin_boards_path) }
    column :title
    column :author
    column :published_at
    column :bbs_pk
    column :post_pk
  end

  form do |f|
    f.semantic_errors

    f.inputs do # 스타일이 입혀지도록 강제
      f.input :title
      f.input :author
      f.input :published_at
      f.input :bbs_pk
      f.input :post_pk
      f.input :board
    end

    f.actions
  end
end

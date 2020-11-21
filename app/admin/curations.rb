ActiveAdmin.register Curation do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    id_column
    column :title
    column :description
    column("큐레이션에 포함된 게시판") do |curation|
      curation.boards.map do |board|
        link_to(board.category ,admin_board_path(board))
      end.join("&nbsp;").html_safe
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      f.input :description
    end

    f.actions
  end
end

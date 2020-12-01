ActiveAdmin.register Board do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :category, :description, :bbs_pk, :curation_id, :source_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:category, :description, :bbs_pk, :curation_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    id_column
    column :category
    column :description
    column :bbs_pk
    column :source_url
    column :curation
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :category
      f.input :description
      f.input :source_url
      f.input :bbs_pk
      f.input :curation
    end

    f.actions
  end
end

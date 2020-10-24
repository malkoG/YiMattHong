class TableComponent < ViewComponent::Base
  include ViewComponent::Slotable

  with_slot :header, class_name: "Header"
  with_slot :row, collection: true, class_name: "Row"

  def initialize(fields: [:id, :created_at, :updated_at])
    @fields = fields
  end

  class Header < ViewComponent::Slot
    def initialize(classes: "")
      @classes = classes
    end
  end

  class Row < ViewComponent::Slot
    include Rails.application.routes.url_helpers

    attr_reader :item, :url

    def initialize(item: {}, controller: '', action: '', is_resource: false)
      @item = item
      @url = url

      if controller.blank? && action.blank? && url.nil? && is_resource
        @url = url_for(
          controller: item.class.name.pluralize.downcase,
          action: "show",
          id: item.id,
          only_path: true
        )
      end
    end
  end
end

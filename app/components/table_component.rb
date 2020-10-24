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
    attr_reader :item

    def initialize(item: {})
      @item = item
    end
  end
end

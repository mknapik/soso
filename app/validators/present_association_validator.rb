class PresentAssociationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank? or not value.size.in? options[:min]..options[:max]
      record.errors[attribute] << (options[:message] ||
          "number of elements is not between #{options[:min]} and #{options[:max]}"
      )
    end
  end
end

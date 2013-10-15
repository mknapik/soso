class UniqueAssociationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    key = "#{record.class.name.downcase}_id"
    foreign_key = options[:key]
    unless value.blank?
      size = value.map { |v| v.send(foreign_key) }.uniq.size
      unless size == value.size
        record.errors[attribute] << (options[:message] || "#{foreign_key} are not unique")
      end
    end
  end
end

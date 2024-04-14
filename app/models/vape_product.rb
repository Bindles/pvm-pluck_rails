# vape_product.rb
class VapeProduct < ApplicationRecord
  # ...

  def self.to_csv
    attributes = %w[name price desc category]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << [product.name, product.price, product.desc, product.category]
      end
    end
  end

  def self.import(file, import_option_skip, import_option_update, import_option_error)
    CSV.foreach(file.path, headers: true) do |row|
      product = find_or_initialize_by(name: row['name'])
      if product.new_record?
        product.update(row.to_hash)
      else
        if import_option_skip
          # Skip Duplicate Entries
        elsif import_option_update
          product.update(row.to_hash) # Update Existing Entries
        else
          raise "Duplicate entry for #{product.name}" # Raise an Error for Duplicate Entries
        end
      end
    end
  end
  
end


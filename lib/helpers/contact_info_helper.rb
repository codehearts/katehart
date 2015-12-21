module ContactInfo

  @@contacts_dir   = '/contact_info/'
  @@contacts_cache = nil

  # Returns a list of all contact info items.
  #
  def all_contact_info
    @@contacts_cache = @items.select { |item|
      item.identifier.to_s.start_with? @@contacts_dir
    } if @@contacts_cache.nil?

    return @@contacts_cache
  end

  # Returns a single contact item by filename.
  #
  def contact_info_item(contact_info_name)
    contact_file = @@contacts_dir + contact_info_name + '.*'
    return all_contact_info.select { |item|
      item.identifier =~ contact_file
    }.first
  end

  # Returns all contact items, or only those corresponding
  # to the given filenames.
  #
  def contact_info_items(contact_info_names = nil)
    # Return all known contact items if no names were given
    return all_contact_info if contact_info_names.nil?

    # Only return contact items with the requested names
    return all_contact_info.select { |item|
      contact_info_names.any? { |name| item =~ "#{name}.*" }
    }
  end

  # Returns all contact items, or only those corresponding to
  # the specified names in the given order.
  #
  def ordered_contact_info_items(contact_info_names = nil)
    # Return all known contact items if no names were given
    return all_contact_info if contact_info_names.nil?
   
    # Only return contact items with the requested names,
    # in the given order
    return contact_info_names.collect { |name|
      contact_info_item(name)
    }
  end

end

include ContactInfo

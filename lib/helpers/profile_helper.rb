module Profile

  @@profiles_dir   = '/profiles/'
  @@profiles_cache = nil

  # Returns a list of all profile items.
  #
  def all_profiles
    @@profiles_cache = @items.select { |item|
      item.identifier.to_s.start_with? @@profiles_dir
    } if @@profiles_cache.nil?

    return @@profiles_cache
  end

  # Returns a single profile item by filename.
  #
  def profile_item(profile_name)
    profile_file = @@profiles_dir + profile_name + '.*'
    return all_profiles.select { |item|
      item.identifier =~ profile_file
    }.first
  end

  # Returns all profile items, or only those corresponding
  # to the given filename.
  #
  def profile_items(profile_names = nil)
    # Return all profile items if no names were given
    return all_profiles if profile_names.nil?

    # Only return profile items with the requested names
    return all_profiles.select { |item|
      profile_names.any? { |name| item =~ "#{name}.*" }
    }
  end

  # Returns all profile items, or only those corresponding to
  # the specified names in the given order.
  #
  def ordered_profile_items(profile_names = nil)
    # Return all profile items if no names were given
    return all_profiles if profile_names.nil?

    # Only return profile items with the requested names,
    # in the given order
    return profile_names.collect { |name|
      profile_item(name)
    }
  end

end

include Profile

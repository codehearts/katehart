module Profile

	# Content directory where profiles are stored
	@@profiles_dir = '/profiles/'
	# Cache of known profile items
	@@known_profiles = nil

	# Caches all profile items
	def cache_profiles
		if @@known_profiles == nil
			@@known_profiles = @items.select { |item|
        item.identifier.to_s.start_with? @@profiles_dir
      }
		end
	end

	# Gets a single profile item
	def profile_item(profile)
		# Cache known profiles
		cache_profiles

    profile_file = @@profiles_dir + profile + '.*'
		@@known_profiles.select { |item| item.identifier =~ profile_file }.first
	end

	# Gets all profile items, or only those with the specified names
	def profile_items(profiles = nil)
		# Cache known profiles
		cache_profiles

		if profiles == nil
			# Return all known profile items
			@@known_profiles
		else
			# Only return profile items with the requested names

			# Prepend the profile path to the profile names
			profiles = profiles.map { |item| @@profiles_dir + item }
			@@known_profiles.select { |item| profiles.include? item.identifier.to_s }
		end
	end

	# Gets all profile items, or only those with the specified names in the specified order
	def ordered_profile_items(profiles = nil)
		# Cache known profiles
		cache_profiles

		if profiles == nil
			# Return all known profile items
			@@known_profiles
		else
			# Only return profile items with the requested names,
			# in the requested order

			ordered_profiles = []
			profiles.each do |profile|
				ordered_profiles << profile_item(profile)
			end

			ordered_profiles
		end
	end

end

include Profile

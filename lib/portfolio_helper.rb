module Portfolio

	# Content directory where portfolio entries are stored
	@@portfolio_dir = '/data/portfolio/'
	# Content subdirectory where in-progress portfolio entries are stored
	@@in_progress_dir = @@portfolio_dir + 'in-progress/'
	# Content subdirectory where scrapped portfolio entries are stored
	@@scraps_dir = @@portfolio_dir + 'scraps/'
	# Cache of known portfolio items
	# Hash with keys 'all', 'completed', 'in-progress', and 'scraps'
	@@known_portfolio_entries = nil

	# Caches all portfolio items
	def cache_portfolio_entries
		if @@known_portfolio_entries == nil
			all = @items.select { |item| item.identifier.start_with? @@portfolio_dir }
			ongoing = all.select { |item| item.identifier.start_with? @@in_progress_dir }
			scraps = all.select { |item| item.identifier.start_with? @@scraps_dir }
			completed = all.select { |item| not (ongoing.include? item or scraps.include? item) }

			@@known_portfolio_entries = {
				'all'         => all,
				'completed'   => completed,
				'in-progress' => ongoing,
				'scraps'      => scraps,
			}
		end
	end

	# Gets all portfolio items of the given type sorted by their `date` value
	# Valid types are 'all', 'completed', 'in-progress', and 'scraps'.
	def portfolio_items(type='completed')
		# Cache known portfolio entries
		cache_portfolio_entries

		@@known_portfolio_entries[type].sort_by { |item| attribute_to_time(item[:date]) }.reverse
	end

end

include Portfolio

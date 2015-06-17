module Portfolio

	# Content directories where portfolio entries are stored
	@@portfolio_dir   = '/portfolio/'
	@@scraps_dir      = @@portfolio_dir + 'scraps/'
	# Cache of known portfolio items
	# Hash with keys 'all', 'completed', and 'scraps'
	@@known_portfolio_entries = nil

	# Caches all portfolio items
	def cache_portfolio_entries
		if @@known_portfolio_entries == nil
			all = @items.select { |item| item.identifier.start_with? @@portfolio_dir }
			scraps = all.select { |item| item.identifier.start_with? @@scraps_dir }
			completed = all.select { |item| not (scraps.include? item) }

			@@known_portfolio_entries = {
				'all'         => all,
				'completed'   => completed,
				'scraps'      => scraps,
			}
		end
	end

	# Gets all portfolio items of the given type sorted by their `date` value.
	# Valid type arguments are 'all', 'completed', 'and 'scraps'.
	def portfolio_items(type='completed')
		# Cache known portfolio entries
		cache_portfolio_entries

		@@known_portfolio_entries[type].sort_by { |item| attribute_to_time(item[:date]) }.reverse
	end

end

include Portfolio

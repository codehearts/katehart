module Portfolio

  # Content directories where portfolio entries are stored
  @@portfolio_dir = '/portfolio/'
  @@scraps_dir    = @@portfolio_dir + 'scraps/'
  @@disabled_dir  = @@portfolio_dir + 'disabled/'
  @@portfolio_entry_cache = nil

  # Returns all portfolio items as a Hash with
  # the following keys:
  #   'all', 'completed', and 'scraps'
  #
  def all_portfolio_entries
    if @@portfolio_entry_cache.nil?
      all       = @items.select { |item| item.identifier.to_s.start_with? @@portfolio_dir }
      scraps    = all.select { |item| item.identifier.to_s.start_with? @@scraps_dir }
      disabled  = all.select { |item| item.identifier.to_s.start_with? @@disabled_dir }
      completed = all.select { |item| not ((scraps.include? item) or (disabled.include? item)) }

      @@portfolio_entry_cache = {
        'all'       => all,
        'completed' => completed,
        'scraps'    => scraps,
        'disabled'  => disabled,
      }
    end

    return @@portfolio_entry_cache
  end

  # Returns all portfolio items of the given type sorted by their `date` value.
  # Valid type arguments are 'all', 'completed', 'and 'scraps'.
  #
  def portfolio_items(type = 'completed')
    all_portfolio_entries[type].sort_by { |item| attribute_to_time(item[:date]) }.reverse
  end

end

include Portfolio

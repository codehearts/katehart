module Contacts

	# Returns a list of contacts
	# Contacts are identified by having their `type` metadata set to "contact"
	def contacts
		@items.select { |item| item[:type] == 'contact' }
	end

	# Returns a list of contacts sorted by their `order` metadata
	def sorted_contacts
		contacts.sort_by { |p| attribute_to_time(p[:order]) }
	end
end

include Contacts

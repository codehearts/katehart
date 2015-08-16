module ContactInfo

	# Content directory where contacts are stored
	@@contacts_dir = '/contact_info/'
	# Cache of known contact items
	@@known_contacts = nil

	# Caches all contact items
	def cache_contact_info
		if @@known_contacts == nil
			@@known_contacts = @items.select { |item| item.identifier.start_with? @@contacts_dir }
		end
	end

	# Gets a single contact item
	def contact_info_item(contact_info)
		# Cache known contacts
		cache_contact_info

		@@known_contacts.select { |item| item.identifier == @@contacts_dir + contact_info + '/' }.first
	end

	# Gets all contact items, or only those with the specified names
	def contact_info_items(contact_info = nil)
		# Cache known contacts
		cache_contact_info

		if contact_info == nil
			# Return all known contact items
			@@known_contacts
		else
			# Only return contact items with the requested names

			# Prepend the contacts path to the contact names
			contact_info = contact_info.map { |item| @@contacts_dir + item + '/' }
			@@known_contacts.select { |item| contact_info.include? item.identifier }
		end
	end

	# Gets all contact items, or only those with the specified names in the specified order
	def ordered_contact_info_items(contact_info = nil)
		# Cache known contacts
		cache_contact_info

		if contact_info == nil
			# Return all known contact items
			@@known_contacts
		else
			# Only return contact items with the requested names,
			# in the requested order

			ordered_contact_info = []
			contact_info.each do |contact|
				ordered_contact_info << contact_info_item(contact)
			end

			ordered_contact_info
		end
	end

end

include ContactInfo

module Contacts

	# Content directory where contacts are stored
	@@contacts_dir = '/data/contacts/'
	# Cache of known contact items
	@@known_contacts = nil

	# Caches all contact items
	def cache_contacts
		if @@known_contacts == nil
			@@known_contacts = @items.select { |item| item.identifier.start_with? @@contacts_dir }
		end
	end

	# Gets a single contact item
	def contact_item(contact)
		# Cache known contacts
		cache_contacts

		@@known_contacts.select { |item| item.identifier == @@contacts_dir + contact + '/' }.first
	end

	# Gets all contact items, or only those with the specified names
	def contact_items(contacts = nil)
		# Cache known contacts
		cache_contacts

		if contacts == nil
			# Return all known contact items
			@@known_contacts
		else
			# Only return contact items with the requested names

			# Prepend the contacts path to the contact names
			contacts = contacts.map { |item| @@contacts_dir + item + '/' }
			@@known_contacts.select { |item| contacts.include? item.identifier }
		end
	end

	# Gets all contact items, or only those with the specified names in the specified order
	def ordered_contact_items(contacts = nil)
		# Cache known contacts
		cache_contacts

		if contacts == nil
			# Return all known contact items
			@@known_contacts
		else
			# Only return contact items with the requested names,
			# in the requested order

			ordered_contacts = []
			contacts.each do |contact|
				ordered_contacts << contact_item(contact)
			end

			ordered_contacts
		end
	end

end

include Contacts

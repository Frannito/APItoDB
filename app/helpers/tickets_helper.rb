
module TicketsHelper

	def self.loadAPIData
		
		page=1
		url='https://casounico.zendesk.com/api/v2/search.json?query=subject%3A%22Status+Solicitud+Devoluci%C3%B3n+Documento+LATAM%22'
		next_page= true

		while next_page do
			puts 'PAGE:'+page.to_s

			user = ''
			pass = ''

			response = RestClient::Request.execute(method: :get, url: url, user: user, password: pass)
			json = JSON.parse(response)

			json["results"].each do |t|

				t_id = t["id"]
				t_subject = t["subject"]
				t_desc = t["description"]

				#INICIO Segmento para búscar número de ticket dentro de la descripción, si no lo encuentra se despliega descripción completa
				t_index = t_desc.index('-')

				if t_index
					t_description = t_desc[(t_index-3)..(t_index)+10]
				else 
					t_description = t_desc
				end
				#FIN Segmento

				t_status = t["status"]

				ticket = Ticket.create(
							id: t_id, #Número de caso
							subject: t_subject,
      						description: t_description, #Número de ticket
      						status: t_status,
      						zendesk_id: t_desc #descripción completa del caso
      						)			
			end

			url = json["next_page"]

			if url
				page +=1
			else
				next_page = false
			end
		end

		puts "PAGES PROCESSED: "+page.to_s

		
	end
end

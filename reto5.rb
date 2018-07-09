=begin
Algunas preguntas que te puedes hacer:
Entiendes completamente la logica del juego?
que clases (estado y comportamiento) necesitas?
Cuales son las responsabilidades de cada clase? 
Que metodos deberían ser publicos? cuales deberian ser privados?

Algunas preguntas para que consideres: 
Como vas a generar objetos de preguntas y respuestas basados en archivo de texto?
como van a interactuar tus clases
Donde debería vivir la logica de del juego? 

Algunas preguntas para considerar:
Como verificas que la respuesta del jugador es correcta? Donde debería vivir esta logica?
como manejas respuestas incorrectas?

Esta es una forma muy basica de guardar los datos sobre las definiciones y las respuestas. Definición en una linea,
respuesta en la siguiente y un espacio en blanco entre definiciones. 

				archivo de definiciones y respuestas
				utilizar archivo.text que puede contener definiciones y preguntas

				Crear un segundo nombre para una variable metodo (Definicion)
				alias (Respuesta)

				Usado para definir una funcion (Definicion)
				def (Respuesta) 
	
¿Cómo represento las preguntas con su respectiva respuesta como un objeto?
¿Donde guardo o como represento estas preguntas con sus respectivas respuestas?
¿Cómo saco todas las de preguntas con su respectivas respuestas del archivo .txt?
¿Cómo represento cada pregunta con su respectiva respuesta bajo el rol de la máquina?
Las preguntas no pueden tomarse aleatorias porque pueden salir las misma una y otra ves
¿Cómo saco la pregunta y la respuesta por aparte de cada tanda para poder utilizarla en la lógica y comparar la respuesta con la que ingresa el usuario?

=end

#--------------------------------ESTRUCTURA DE DATOS------------------#

#Contenedor de preguntas con sus respectivas respuestas, valores por defecto de la pareja
#Se crea al momento de dar Decklist.new es decir cuando se inicializa la clase Decklist
class Showcouple
	attr_reader :question, :answer

	def initialize(question,answer)
		@question = question
		@answer = answer
	end

	def question
		return @question # se necesita para sacar las preguntas con la class Gamequestion
	end

	def answer
		return @answer # se necesita para sacar las respuestas con la class Gamequestion
	end

	#solucionar problema de imprimir string de parejas couple # no se necesita en este proyecto
	# def to_s
	# 	"#{@question} - #{@answer}" # se necesita para sacar las preguntas con su respectivas respuestas con la class Gamequestion

	# end
end

#Obtiene las preguntas y respuestas las adecua y las manda al contenedor, esta es la class principal todas depende de esta
class Decklist
	attr_reader :couple

	def initialize # esto es lo que se inicializa en esta clase
		@couple = [] # arreglo de parejas vacío
		extract_couple # método privado para extracción de información del archivo se ejecuta por defecto cuando se da Decklist.new
	end

	def take! #altera el arreglo original va quitando uno por uno, se ejecuta en la class Gamequestion
		@couple.shift # saca, toma, o devuelve el primer elemento del arreglo
	end

	private
	def extract_couple(file="file.txt")
		question = [] #arreglo para preguntas vacío
		answer = [] #arreglo para respuestas vacío
		
		lines = File.foreach(file) #Leer archivo .txt
		lines.with_index do |line,line_number|
			if (line_number%2==0) #lee líneas impares preguntas
				# puts "#{line_number+1} #{line}"
				question << line.strip # con el strip quito el /n
				# puts "#{question}"

			else #lee líneas pares respuestas
				answer <<line.strip # con el strip quito el /n
			end

		end
		#arreglo de arreglos adaptado, par de pregunta y respuesta ordenados 
		cuoples = question.zip(answer)
		#extracción por iteración
		cuoples.each do |question,answer|
			@couple <<Showcouple.new(question,answer) #se meten todas las preguntas y respuestas del archivo .txt en la clase Showcouple
			# puts "#{question}"
			# puts "#{answer}"
			# puts "#{@couple}"
		end
		# @couple.shuffle! # no conviene que sea aleatorio porque pueden repetirse las preguntas
	end
end

#clase de la máquina o juego que se utiliza cuando primero se ejecuta Decklist.new, depende directamente de la class Decklist y por consecuencia de Showcouple
class Gamequestion
	attr_reader :couple

	def initialize(decklist) # decklist es un argumento que debe ser: decklist = Decklist.new que es la generación de la baraja de preguntas
	@decklist = decklist # Decklist.new es decir la baraja de preguntas
	@couple = [] #arreglo para guardar la pareja de pregunta y respuesta al ejecutar hit
	end

	# Saca una pregunta con su respectiva respuesta  del contenedor cada ves que se ejecuta el hit
	def hit! # se invoca el método take de la class Dakelist
	@couple << @decklist.take! # saca /toma una pareja de la baraja de preguntas y respuestas y la inserta en este arreglo
	end

	#devuelve la última pregunta cuando se ejecuta este método
	def question
	@question = [] #arreglo de preguntas
	@couple.each do |couple|
		@question << "#{couple.question} " #invoca método question de Showcouple para devolver preguntas lo concatena al arreglo
		end
		return @question.last.strip #retorna del arreglo preguntas el último elemento y se convierte en string con strip
	end

	#devuelve la última respuesta cuando se ejecuta este método
	def answer
	@answer = [] #arreglo de respuestas
	@couple.each do |couple|
		@answer << "#{couple.answer} " #invoca método answer de Showcouple para devolver respuestas lo concatena al arreglo
		end
		return @answer.last.strip #retorna del arreglo respuestas el último elemento y se convierte en string con strip
	end

	# solucionar problema de impresión :: string de parejas couple ## no se necesita en este proyecto
	# def to_s
	# 	str = ""
	# 	@couple.each do |couple|
	# 		str += "#{couple}  "
	# 	end	
	# 	str.strip	
	# end
end

#------------------------------PRUEBAS DE ESTRUCTURAS DE DATOS----------------------------------#

# decklist = Decklist.new #genera el listado de preguntas y respuestas y quedan guardadas en el contenerdor
# gamequestion = Gamequestion.new(decklist) # pasa este listado a esta clase Gamequestion
# puts "el arreglo tiene #{decklist.couple.length} parejas de preguntas y respuestas" # el arreglo tiene 7 parejas de preguntas y respuestas
# gamequestion.hit! # se saca una pareja de la bolsa
# puts "el arreglo tiene #{decklist.couple.length} parejas de preguntas y respuestas" # el arreglo tiene 6 parejas de preguntas y respuestas
# puts "El juego tiene #{gamequestion.couple.length} pareja de pregunta y respuesta para hacer" # el juego tiene 1 pareja de pregunta y respuesta para hacer
# puts "#{gamequestion.question}" #imprime pregunta -- De que color es el cielo
# puts "#{gamequestion.answer}" #imprime la respuesta -- Azul
# # puts "#{gamequestion}" #imprime la pregunta y la respuesta -- De que color es el cielo - Azul
# gamequestion.hit! # se saca una pareja de la bolsa
# puts "#{gamequestion.question}" #imprime pregunta --  Cuantos años tiene un hombre
# puts "#{gamequestion.answer}" #imprime la respuesta -- dos

#----------------------------------LÓGICA------------------------------#
=begin
1. Saludo de bienvenida y si está de acuerdo en empezar a jugar teclee S o N
		si responde N aparece un mensaje y se sale
		si responde S empieza el juego
		1. La máquina saca una pregunta de las N preguntas disponibles del archivo
		2. se da el espacio para que responda el usuario
		3. si la respuesta es correcta sigue con la siguiente pregunta
		4. si la respuesta es incorrecta
				la máquina vuelve y hace la misma pregunta y vuelve y da el espacio para que responda el usuario, 
				hasta que el usuario responda bien, continua y pasa a la siguiente pregunta es decir vuelve al punto 1
		5. al responder todas las N preguntas disponibles correctamente se gana y se sale
=end

		puts "Bienvenido al reto 5, Para jugar, solo ingresa el termino correcto para cada una de las definiciones"
		puts  "¿Listo para empezar, decide (S) o (N)?"
		responde = gets.chomp # ingrese respuesta el usuario si quiere jugar o no

		if responde == "S" 
			allcouples = Decklist.new # crea la lista de preguntas con sus respectivas respuestas
			gamequestion = Gamequestion.new(allcouples) # meto la lista anterior en la clase Gamesquestion para que la máquina pueda preguntar más adelante

			while (allcouples.couple.length >0) # cuando la bolsa de preguntas se acabe se sale

			gamequestion.hit! # máquina saca una pareja
			puts "*Definición"
			puts "*#{gamequestion.question}" #la máquina hace la pregunta
			responde1 = gets.chomp #usuario responde
			puts
			#Hasta que no responda bien el usuario la máquina vuelve y hace la misma pregunta
				while responde1 != "#{gamequestion.answer}"
					puts "Incorrecto! Trata de nuevo"
					puts
					puts "*Definición"
					puts "*#{gamequestion.question}"
					responde1 = gets.chomp
					puts
				end
			#Usuario responde bien
				if responde1 == "#{gamequestion.answer}"
					puts "Correcto!"
					puts
				end

			end
			# fin del juego cuando se ha respondido todas las preguntas
			puts "El juego ha terminado, felicitaciones has ganado respondite todas las preguntas bien!"
			
			# Se arrepiente y no quiere empezar el juego
		 elsif responde == "N"
		 	puts
		 	puts "El juego ha terminado, no has jugado nada ni ganado nada!"
		 	
		end



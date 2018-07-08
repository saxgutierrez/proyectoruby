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
		return @question.last.to_s #retorna del arreglo preguntas el último elemento y lo convierte en string
	end

	#devuelve la última respuesta cuando se ejecuta este método
	def answer
	@answer = [] #arreglo de respuestas
	@couple.each do |couple|
		@answer << "#{couple.answer} " #invoca método answer de Showcouple para devolver respuestas lo concatena al arreglo
		end
		return @answer.last.to_s #retorna del arreglo respuestas el último elemento y lo convierte en string
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
# puts "#{gamequestion.question}" #imprime pregunta -- De que color es el cielo Cuantos años tiene un hombre
# puts "#{gamequestion.answer}" #imprime la respuesta -- Azul dos
# # puts "#{gamequestion}" #imprime la pregunta y la respuesta -- De que color es el cielo - Azul Cuantos años tiene un hombre - dos
# gamequestion.hit! # se saca una pareja de la bolsa
# puts "#{gamequestion.question}" #imprime pregunta -- De que color es el cielo Cuantos años tiene un hombre
# puts "#{gamequestion.answer}" #imprime la respuesta -- Azul dos


#----------------------------------LÓGICA------------------------------#
=begin
1. Saludo de bienvenida y si está de acuerdo en empezar a jugar teclee S o N
		2. Pregunta del juego
			lee las preguntas del archivo .txt en orden consecutivo cada ves que se entra aquí
		3. Usuario responde
		4. el juego responde
			lee la respuesta respectiva de la pregunta del archivo txt y la compara con la respuesta del usuario
				si la respuesta es correcta se le indica al usuario que es Correcto! y vuelve al punto 2
				si la respuesta es incorrecta se le indica al usuario que es Incorrecto! Trata de Nuevo y vuelve al punto 3
		5. termina el juego
			 al ingresar el usuario la última respuesta correcta, pasa al punto 2 y al no encontrar más preguntas
				le informa al usuario que el Juego ha Terminado y ha ganado!	
=end

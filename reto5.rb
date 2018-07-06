=begin
1. usuario ingrese respuesta a cada pregunta
2. el juego responda si la respuesta es correcta
3. en caso que sea correcta se sigue con una nueva pregunta
4. en caso que sea incorrecta se le indica al usuario que vuelta a intentar una nueva respuesta
5. archivo de definiciones y respuestas
6. utilizar archivo.text que puede contener definiciones y preguntas
	Crear un segundo nombre para una variable metodo (Definicion)
	alias (Respuesta)

	Usado para definir una funcion (Definicion)
	def (Respuesta) 
Esta es una forma muy basica de guardar los datos sobre las definiciones y las respuestas. Definición en una linea, respuesta en la siguiente y un espacio en blanco entre definiciones. 

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
Que sucede cuando el jugador empieza el juego? 
que sucede cuando el jugador termina el juego?
como manejas respuestas incorrectas?
=end

class Player

end

class Game

end

def read(file)
	x=0
	lines = File.foreach(file)
	lines.with_index do |line,line_number|
		
		if (line_number%2==0) #lee líneas impares
			puts "#{line_number+1} #{line}"
		end

		if !(line_number%2==0) #lee líneas pares
			puts "#{line_number+1} #{line}"
		end

		x+=1
		# if (x%2==0) #lee números pares
		# 	puts "#{line_number} #{line}"
		# end
		
		# if !(x%2==0) #lee números impares
		# 	puts "#{line_number} #{line}"
		# end
	

	end
end

read("file.txt")
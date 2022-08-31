import Foundation

struct Persona: Codable {
    
    let id: String?
    let nombre: String
    let edad: Int
    let carro: Bool
    
    init(id:String?, nombre: String, edad: Int, carro: Bool) {
        self.id = id
        self.nombre = nombre
        self.edad = edad
        self.carro = carro
    }
    
}

struct Respuesta: Decodable {
    
    let metodo: String
    let salida: Bool
    
    init(metodo: String, salida: Bool) {
        self.metodo = metodo
        self.salida = salida
    }
}

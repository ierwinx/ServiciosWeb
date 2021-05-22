import Foundation

class PersonaRepository {
    
    private let urlBase = "http://localhost:3000"
    
    public func guardar() -> Void {
        print("Se guardaran datos")
        guard let endpoint: URL = URL(string: "\(urlBase)/guardar") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let persona = Persona(id: nil, nombre: "Diana", edad: 29, carro: true)
        
        guard let body = try? JSONEncoder().encode(persona) else {
            return
        }

        request.httpBody = body
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                print(error!)
                return
            }
            
            guard let dataRes = data, let personaR: Persona = try? JSONDecoder().decode(Persona.self, from: dataRes) else {
                print("No se pudo parsear")
                return
            }
            
            DispatchQueue.main.sync {
                print(personaR)
            }
                        
        }
        tarea.resume()
        
    }
    
    public func actualizar() -> Void {
        print("Se actualizaran datos")
        guard let endpoint: URL = URL(string: "\(urlBase)/actualizar") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        let persona = Persona(id: "65RFGU7865RFU76", nombre: "Erwin", edad: 29, carro: true)
        
        guard let body = try? JSONEncoder().encode(persona) else {
            return
        }

        request.httpBody = body
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                print(error!)
                return
            }

            guard let dataRes = data, let respuesta: Respuesta = try? JSONDecoder().decode(Respuesta.self, from: dataRes) else {
                print("No se pudo parsear")
                return
            }
            
            DispatchQueue.main.sync {
                print(respuesta)
            }
                        
        }
        tarea.resume()
        
    }
    
    public func buscar() -> Void {
        
        print("Se buscara dato")
        
        guard let endpoint: URL = URL(string: "\(urlBase)/buscar/65RFGU7865RFU76") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                print(error!)
                return
            }
            
            guard let dataRes = data, let personaR: Persona = try? JSONDecoder().decode(Persona.self, from: dataRes) else {
                print("No se pudo parsear")
                return
            }
            
            DispatchQueue.main.sync {
                print(personaR)
            }
            
        }
        tarea.resume()
        
    }
    
    public func buscarAll() -> Void {
        print("Se buscaran datos")
        guard let endpoint: URL = URL(string: "\(urlBase)/buscarAll") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                print(error!)
                return
            }
            
            guard let dataRes = data, let personaR: [Persona] = try? JSONDecoder().decode([Persona].self, from: dataRes) else {
                print("No se pudo parsear")
                return
            }
            
            DispatchQueue.main.sync {
                print(personaR)
            }
                        
        }
        tarea.resume()
        
    }
    
    public func borrar() -> Void {
        print("Se eliminaran datos")
        guard let endpoint: URL = URL(string: "\(urlBase)/borrar/65RFGU7865RFU76") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                print(error!)
                return
            }
            
            guard let dataRes = data, let respuesta: Respuesta = try? JSONDecoder().decode(Respuesta.self, from: dataRes) else {
                print("No se pudo parsear")
                return
            }
            
            DispatchQueue.main.sync {
                print(respuesta)
            }
                        
        }
        tarea.resume()
    }
    
}

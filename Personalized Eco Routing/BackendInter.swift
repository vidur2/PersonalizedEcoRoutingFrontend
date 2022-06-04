//
//  BackendInter.swift
//  Personalized Eco Routing
//
//  Created by Vidur Modgil on 6/1/22.
//
import Foundation

struct LatitudeLongitude {
    var Lat: Float,
    Long: Float
}

struct LoadUserDataRes: Decodable {
    let valid: Bool,
        error: String
}

class BackendInter {
    
    let backendUri  = "http://localhost:8080"
    
    private var res: Data? = nil;
    
    func getDirections(start: String, end: String) -> Data? {
        
        let parameters: [String: String?] = [
            "user": ConfigManager.shared.getEmailAddress(),
            "start": start,
            "end": end,
            "oauth_token": ConfigManager.shared.getIdToken()
        ]
        
        return sendRequest(path: "/get_directions", params: parameters)
    
    }
    
    func loadUserData() -> Bool {
        
        let parameters: [String: String?] = [
            "email": ConfigManager.shared.getEmailAddress(),
            "token": ConfigManager.shared.getIdToken()
        ]
        
        var res = self.sendRequest(path: "/load_user_data", params: parameters)
        
        if res != nil {
            let userDataRes = try! JSONDecoder().decode(LoadUserDataRes.self, from: res!)
            
            return userDataRes.valid
        } else {
            return loadUserData()
        }
    }
    
    func updateModel(actualSpeeds: Array<Float>, positions: Array<LatitudeLongitude>) -> Data? {
        let parameters: [String: Any] = [
            "email": ConfigManager.shared.getEmailAddress(),
            "actual_speeds": actualSpeeds,
            "positions": positions,
            "token": ConfigManager.shared.getIdToken()
        ]
        
        return self.sendRequest(path: "/update_model", params: parameters)
    }
    
    func createUser(fuelEff: Float) -> Data? {
        let parameters: [String: Any] = [
            "username": ConfigManager.shared.getEmailAddress(),
            "token": ConfigManager.shared.getIdToken(),
            "fuel_efficency": fuelEff
        ]
        return self.sendRequest(path: "/create_user", params: parameters)
    }
    
    func deleteUser() -> Data? {
        let parameters: [String: String?] = [
            "email": ConfigManager.shared.getEmailAddress(),
            "token": ConfigManager.shared.getIdToken()
        ]
        
        return self.sendRequest(path: "/delete_user", params: parameters)
    }
    
    private func sendRequest(path: String, params: [String: Any]) -> Data? {
        self.res = nil
        
        let url = URL(string: self.backendUri + path)
        
        let valid = _sendRequest(url: url, params: params)
        
        if valid && self.res != nil {
            return self.res
        } else {
            return nil
        }
    }
    
    private func _sendRequest(url: URL?, params: [String: Any]) -> Bool {
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        do {
            let decoded = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = decoded
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error: \(error!)")
                } else {
                    self.res = data!
                }
            })
            
            task.resume()
            while !task.progress.isFinished { print("In progress...") }
            
            return true
            
        } catch {
            print(error.localizedDescription)
            
            return false
        }
    }
}


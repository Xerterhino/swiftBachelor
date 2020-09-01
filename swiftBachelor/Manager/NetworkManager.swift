import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    @Published var activities = Array<Activity>()
    @Published var createdActivity: Activity = Activity(_id: "aa", name: "asds", duration: "0")
    
  init() {
    loadDataNormal();
  }
    
    public func loadDataNormal() {
        guard let url = URL(string: "http://192.168.178.44:8080/api/activity") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let acts = try! JSONDecoder().decode(Array<Activity>.self, from: data)
            DispatchQueue.main.async {
                self.activities = acts
            }
        }.resume()
    }
    
    public func createActivity(activityName: String) -> Activity?  {
        guard let url = URL(string: "http://192.168.178.44:8080/api/activity") else {
            print("CRASHED CREATING")
            return Activity(_id: "error", name: "error", duration: "0")
        }
        let body: [String: String] = ["name": activityName, "duration": "0", "finished": "false"]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var createdActivity: Activity = Activity(_id: "aa", name: "asds", duration: "0")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data else { return }

            let resData = try! JSONDecoder().decode(Activity.self, from: data)
        
            
                DispatchQueue.main.async {
                    self.createdActivity = resData;
                    createdActivity = resData;
                    self.loadDataNormal();
                     print("SELECTED INSIDE",createdActivity)
            }


        }.resume()       
        return createdActivity;
    }
    
    public func deleteActivity(activityID: String)  {
        guard let url = URL(string: "http://192.168.178.44:8080/api/activity/\(activityID)") else {
            print("CRASHED CREATING")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard data != nil else { return }

            //let resData = try! JSONDecoder().decode(Activity.self, from: data)
        
                DispatchQueue.main.async {
                    self.loadDataNormal();
            }


        }.resume()
    }
    
    public func updateActivity(activityID: String, activityName: String, duration: String) {
            guard let url = URL(string: "http://192.168.178.44:8080/api/activity/\(activityID)") else { return }
            let body: [String: String] = ["name": activityName, "duration": duration, "finished": "false"]

            let finalBody = try! JSONSerialization.data(withJSONObject: body)

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                guard let data = data else { return }

                let resData = try! JSONDecoder().decode(Activity.self, from: data)

                print(resData)
                //self.loadDataNormal();
    /*
                if response == "correct" {
                    DispatchQueue.main.async {
                        self.loadDataNormal()
                    }

                }
    */
            }.resume()
    }

}

/*
import Foundation

final class NetworkManager {

  var activities: [Activity] = []
  private let domainUrlString = "http://192.168.178.20:8080/api/"
  
  func fetchFilms(completionHandler: @escaping ([Activity]) -> Void) {
    let url = URL(string: domainUrlString + "activities/")!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(response)")
        return
      }

        /*
      if let data = data,
        let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
        completionHandler(filmSummary.results ?? [])
      }
         */
    })
    task.resume()
  }
}
 */
/*
  private func fetchFilm(withID id:Int, completionHandler: @escaping (Film) -> Void) {
    let url = URL(string: domainUrlString + "films/\(id)")!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print("Error returning film id \(id): \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
        print("Unexpected response status code: \(response)")
        return
      }

      if let data = data,
        let film = try? JSONDecoder().decode(Film.self, from: data) {
          completionHandler(film)
      }
    }
    task.resume()
  }
}
*/

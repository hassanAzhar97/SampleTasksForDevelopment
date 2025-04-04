//
//  APICaller.swift
//  NetFlix-Demo
//
//  Created by Hassan Azhar on 02/08/2022.
//

import Foundation

struct Constants{
    static let API_KEY = "60780745d9e5d5e98b7af36916196d72"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIerror: Error {
    case failedTogetData
}


class APICaller{
    static let shared = APICaller()
    func getTrendingMovies(completion: @escaping (Result<[Title],Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)")
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error==nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIerror.failedTogetData))
            }
        }
        task.resume()
    }
    func getTrendingTvs (completion: @escaping ( Result<[Title],Error>)->Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)")
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
                guard let data = data,error == nil else {
                    return
                }
                do{
                    let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    print(results)
                }
                catch {
                    completion(.failure(APIerror.failedTogetData))
                }
            }
            task.resume()
        }
    func getUpcomingMovies(completion: @escaping ( Result<[Title],Error>)->Void) {
       guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1")
    else {
        return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data,_, error in
            guard let data = data , error == nil
            else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(results)
            }
            catch{
                completion(.failure(APIerror.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping ( Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1")
     else {
         return}
         let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data,_, error in
             guard let data = data , error == nil
             else {
                 return
             }
             do {
                 let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                 print(results)
             }
             catch{
                 completion(.failure(APIerror.failedTogetData))
             }
         }
         
         task.resume()
     }
    func getTopRated(completion: @escaping ( Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1")
     else {
         return}
         let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data,_, error in
             guard let data = data , error == nil
             else {
                 return
             }
             do {
                 let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                 print(results)
             }
             catch{
                 completion(.failure(APIerror.failedTogetData))
             }
         }
         
         task.resume()
     }

}



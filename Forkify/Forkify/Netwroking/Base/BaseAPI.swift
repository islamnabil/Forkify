//
//  BaseAPI.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation
import Alamofire
import PKHUD

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type,view:UIView ,completion:@escaping (Swift.Result<M,NSError>) -> Void) {
        HUD.show(.progress , onView: view)
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        print(target.baseURL + target.path)
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            if statusCode == 200 { // 200 reflect success response
                // Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    HUD.flash(.label(error.accessibilityValue) , onView: view , delay: 2 , completion: nil)
                    
                    completion(.failure(error))
                    return
                }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    HUD.flash(.label(error.accessibilityValue) , onView: view , delay: 2 , completion: nil)
                    completion(.failure(error))
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    HUD.flash(.label(error.accessibilityValue) , onView: view , delay: 2 , completion: nil)
                    completion(.failure(error))
                    return
                }
                HUD.hide()
                completion(.success(responseObj))
            } else {
                // ADD custom error base on status code 404 / 401 /
                // Error Parsing for the error message from the BE
                do {
                    let er = try JSONDecoder().decode(ErrorMsg.self, from: response.data!)
                    HUD.flash(.label("\(er.msg[0] )") , onView: view , delay: 2 , completion: nil)
                }catch {
                    HUD.flash(.label("Something went wrong Please try again later") , onView: view , delay: 2 , completion: nil)
                }
                completion(.failure(NSError()))
            }
        }
    }
    
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}

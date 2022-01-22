//
//  BaseAFService.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 5.01.2022.
//

import Foundation
import Alamofire


protocol BaseRequestProtocol {
    
}

struct emptyRequestModel:BaseRequestProtocol {
    
}

class BaseService<Request:BaseRequestProtocol,Response:Codable> {

    typealias ResultBlock = (Swift.Result<Request, AFError>) -> ()
    
    var timeOutInterval = 30
    
    var baseUrl = URL(string: Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String)
    var apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey")

    var requestModel = Request.self
    var response = Response.self
    var method : Alamofire.HTTPMethod?
    var path : String = String()
    var encoding: ParameterEncoding = URLEncoding.httpBody
    var parameters : Parameters = .init()
    var header : Alamofire.HTTPHeaders = .default
    
    
    func setRequestModel(_ requestModel : Request.Type) -> Self {
        self.requestModel = requestModel
        return self
    }
    
    func setUrlPath(_ string : String) -> Self {
        self.path = string
        return self
    }
    
    func addParameterToUrlPath(_ parameterString : String) -> Self {
        self.path = self.path + "/\(parameterString)"
        return self
    }
    
    func setRequestType(_ method : HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func setEncodingtype(_ type : URLEncoding) -> Self {
        self.encoding = type
        return self
    }
    
}

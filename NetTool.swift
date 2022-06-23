//
//  NetTool.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/7.
//

import UIKit
import Alamofire

let BaseUrl = "https://www.baidu.com"

enum NetWorkStatusType {
    case unknown
    case notreachable
    case mobile
    case wifi
}

class NetworkModel: NSObject {
    var urlString:String! = ""
    var methodType:HTTPMethod! = .get
    var parameters:[String: String]?
    var isAnimation:Bool = true
}


typealias DEFinished = (AnyObject?,NSError?)->Void
typealias DENetworkStatus = (NetWorkStatusType)->Void

class NetTool: NSObject {
    var session : Session?
    var networkManager : NetworkReachabilityManager?
    static let getUrlEncoding = URLEncoding.queryString
    static let postJSONEncoding = JSONEncoding.default
    var httpHeaders:HTTPHeaders = [
        .contentType("application/json"),
        .accept("application/json"),
        .userAgent("IOS"),
        .init(name: "App-Version", value: "1.0.0")
    ]
    
    
}

extension NetTool {
    //MARK: 单例
    static let shareNetManager: NetTool = {
        let share = NetTool()
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 15
        share.session = Session(configuration: configuration)
        share.networkManager = NetworkReachabilityManager(host: "https://www.baidu.com")
        
        return share
    }()
    
    //MARK: 上传数据
    func uploadImageData(_ uploadUrl : String,data :Data, success :DEFinished){
        
        
        self.session?.upload(data, to: uploadUrl, method: .post, headers: nil, interceptor: nil, fileManager: FileManager.default, requestModifier: .none).response(completionHandler: { response in
            
            
            
            
        })
    }
    //MARK: 请求数据
    func requestData(url:String , methodType : HTTPMethod, paramaters : [String : String]? , headers : HTTPHeaders?, success:DEFinished){
        var newUrl = url
        if !newUrl.contains(BaseUrl) {
            newUrl = BaseUrl + newUrl
        }
        self.session?.request(newUrl, method: methodType, parameters: paramaters, encoder: URLEncoding.queryString as! ParameterEncoder, headers: headers).response(completionHandler: { response in
                
            
            
            
            }
        )
    }
    
    
    
    /// 请求数据
    /// - Parameters:
    ///   - urlString: 请求的链接
    ///   - methodType: 请求方式
    ///   - paramaters: 请求的参数
    ///   - finished: 返回的数据
    func requestData(urlString:String , methodType : HTTPMethod,paramaters:[String :String]?,finished:@escaping(_ result: AnyObject?,_ error : NSError?) ->Void )  {
        
        var newUrl = urlString
        if !newUrl.contains(BaseUrl) {
            newUrl = BaseUrl + newUrl
        }
        
        self.session?.request(urlString,method: .get,parameters: paramaters).response(completionHandler: { reponse in
            let ss = self.nsdataToJson(data: reponse.data)
            finished(ss,nil)
        })
    }
    
    //MARK: data数据转json
    func nsdataToJson(data : Data?) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data ?? Data() , options: .mutableContainers) as AnyObject
        }catch {
            print(error)
        }
        return nil
    }
    
    
    
}


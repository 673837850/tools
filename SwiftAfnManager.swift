//
//  SwiftAfnManager.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/16.
//

import UIKit
import Alamofire
import HandyJSON

struct StatusModel : HandyJSON{
    var code: String?
    var errorCode: String?
    var errorDescription: String?
}

class BaseMode : HandyJSON {
    required init() {
        
    }
    //数据
    var data: Any?
    
    //status信息
    var status: StatusModel?
    
}

typealias SuccessHandlerType = ((Dictionary<String, Any>) -> Void)
typealias FailureHandlerType = ((Any?, String) -> Void)

class SwiftAfnManager: NSObject {
    var session : Session?
    var networkManager : NetworkReachabilityManager?
    private var requestType: HTTPMethod = .post
    private var url: String?
    private var params: [String:Any]?
    private var hintText:String?
    private var success: SuccessHandlerType?
    private var failure: FailureHandlerType?
    private var httpRequest: Request?
    private var headers: HTTPHeaders?
    
    //MARK: 单例
    static let shareNetManager: SwiftAfnManager = {
        let share = SwiftAfnManager()
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 15
        share.session = Session(configuration: configuration)
        share.networkManager = NetworkReachabilityManager(host: "https://www.baidu.com")
        
        return share
    }()
    
    ///设置url
    func url(_ url:String?) -> Self {
        self.url = url
        return self
    }
    /// 设置post/get 默认post
    func requestType(_ type:HTTPMethod) -> Self{
        self.requestType = type
        return self
    }
    ///设置参数
    func params(_ params:[String : Any]?) -> Self {
        self.params = params
        return self
    }
    ///成功的回调
    func success(_ handler: @escaping SuccessHandlerType) -> Self{
        self.success = handler
        return self
    }
    
    //发起请求 设置好相关参数后调用
    func request() -> Void {
        var dataRequest:DataRequest?
        if let urlString = url{
            if let hint = hintText{
                
            }
            var requestheaders = HTTPHeaders()
            if let header = headers {
                requestheaders = header
            }else{
                requestheaders.add(name: "Content-Type", value: "application/json;charset=utf-8")
                requestheaders.add(name: "Accept", value: "application/json")
            }
            self.session?.sessionConfiguration.timeoutIntervalForRequest = 15
//            dataRequest = session?.request(urlString, method: .get, parameters: params, encoder: URLEncoding.queryString as! ParameterEncoder, headers: headers).validate()
            dataRequest = self.session?.request(urlString,method: requestType,parameters: params).validate()
            httpRequest = dataRequest
        }
       
        dataRequest?.response(completionHandler: { reponseData in
            guard let value = reponseData.value else {
                self.failure?(reponseData.error?.responseCode,reponseData.error?.localizedDescription ?? "111")
                return
            }
            switch reponseData.result {
            case .success(_):
                guard let baseModel = BaseMode.deserialize(from: value as? Dictionary) else{
                    return
                }
                if let successBlock = self.success{
                    successBlock(baseModel.data as! Dictionary<String, Any>)
                }
                
            case let .failure(error):
                if let failuerBlock = self.failure {
                    failuerBlock(nil,error.localizedDescription)
                }
            }
            
        })
        
    }
    
}

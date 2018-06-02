//
//  AlamofireService.swift
//  PNA-Swift
//
//  Created by An on 5/12/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire
extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}
class AlamofireService: NSObject {
    static let sharedInstance = AlamofireService()
    var totalErrorDisplay: Int = 0
    override init() {
    }
    func isConnectedToNetwork() -> Bool {
        guard let flags = getFlags() else { return false }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    func getFlags() -> SCNetworkReachabilityFlags? {
        guard let reachability = ipv4Reachability() ?? ipv6Reachability() else {
            return nil
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return nil
        }
        return flags
    }
    func ipv6Reachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in6()
        zeroAddress.sin6_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin6_family = sa_family_t(AF_INET6)
        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    func ipv4Reachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    func uploadImage(_url: String, image: UIImage, _completeHandle: @escaping (_ result: AnyObject?, _ code: Int) -> Void) {
        guard let data = UIImageJPEGRepresentation(image, 0.9) else {
            return
        }
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        //defaultHeaders["X-CSRF-Token"] = self.generateHeaderToken(_param: nil, [], usePrivate: false)
        Alamofire.upload(multipartFormData: { (form) in
            form.append(data, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpg")
        }, to: _url, method: .post, headers: defaultHeaders, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseString { response in
                    upload.responseJSON { response in
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            let returnCode: Int! = jsonResult.object(forKey: "status") as! Int
                            switch returnCode {
                            case Global.RETURN_CODE_SUCCESS:
                                _completeHandle(jsonResult.object(forKey: "data") as AnyObject, Global.API_CODE_SUCCESS)
                                break
                            case Global.RETURN_CODE_BAD_REQ:
                                _completeHandle(nil, Global.API_CODE_BAD_REQ)
                                break
                            case Global.RETURN_CODE_BAD_FOR:
                                _completeHandle(nil, Global.API_CODE_BAD_REQ)
                                
                                break
                            case Global.RETURN_CODE_NOT_ACCEPT:
                                _completeHandle (nil, Global.API_CODE_ERROR)
                                break
                            case Global.RETURN_CODE_LOCKED:
                                _completeHandle (nil, Global.API_CODE_ERROR)
                                break
                            case Global.RETURN_CODE_EXPIRE_TOKEN:
                                _completeHandle (nil, Global.API_CODE_EXPIRE)
                                break
                            default:
                                _completeHandle (nil, Global.API_CODE_ERROR)
                                break
                            }
                        }
                        catch {
                            _completeHandle (nil, Global.API_CODE_ERROR)
                        }
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    func receiveData(_url: String, _method: Int = Global.NETWORK_METHOD_POST, _param: [String: Any]? = nil, _showProgress: Bool = false, listHash: [String] = [], usePrivate: Bool = false, ignoreReturn:Bool = false, _completeHandle: @escaping (_ result: AnyObject?, _ code: Int, _ message: String) -> Void) {
        if (!self.isConnectedToNetwork()) {
            return
        }
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["platform"] = "iOS"
        //defaultHeaders["X-CSRF-Token"] = self.generateHeaderToken(_param: _param, listHash, usePrivate: usePrivate)
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var methodHttp: HTTPMethod = .get
        switch _method {
        case Global.NETWORK_METHOD_GET:
            methodHttp = .get
            break
        case Global.NETWORK_METHOD_POST:
            methodHttp = .post
            break
        case Global.NETWORK_METHOD_PUT:
            methodHttp = .put
            break
        case Global.NETWORK_METHOD_DELETE:
            methodHttp = .delete
            break
        default:
            break
        }
        Alamofire.request(_url , method: methodHttp, parameters: _param, encoding: JSONEncoding.default , headers: defaultHeaders)
            .authenticate(user: Global.AUTH_USERNAME, password: Global.AUTH_PASS)
            .responseJSON(completionHandler: {
                json in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if (json.result.isFailure) {
                    _completeHandle (nil, Global.API_CODE_ERROR, "")
                    if (ignoreReturn) {
                        return
                    }
                }
                else {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: json.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        let returnCode: Int! = jsonResult.object(forKey: "status") as! Int
                        switch returnCode {
                        case Global.RETURN_CODE_SUCCESS:
                            _completeHandle(jsonResult.object(forKey: "data") as AnyObject, Global.API_CODE_SUCCESS, "")
                            break
                        case Global.RETURN_CODE_BAD_REQ:
                            _completeHandle(nil, Global.API_CODE_BAD_REQ, (jsonResult.object(forKey: "message") as? String)!)
                            break
                        case Global.RETURN_CODE_BAD_FOR:
                            _completeHandle(nil, Global.API_CODE_BAD_REQ, (jsonResult.object(forKey: "message") as? String)!)
                            break
                        case Global.RETURN_CODE_NOT_ACCEPT:
                            _completeHandle (nil, Global.API_CODE_ERROR, "")
                            break
                        case Global.RETURN_CODE_LOCKED:
                            _completeHandle (nil, Global.API_CODE_ERROR, "")
                            break
                        case Global.RETURN_CODE_EXPIRE_TOKEN:
                            _completeHandle (nil, Global.API_CODE_EXPIRE, "")
                            break
                        default:
                            _completeHandle (nil, Global.API_CODE_ERROR, "")
                            break
                        }
                    } catch {
                        _completeHandle (nil, Global.API_CODE_ERROR, "")
                    }
                }
            })
    }
}

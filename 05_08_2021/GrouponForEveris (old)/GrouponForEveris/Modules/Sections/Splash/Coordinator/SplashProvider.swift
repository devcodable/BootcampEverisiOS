//
//  SplashProvider.swift
//  GrouponForEveris
//
//  Created by David Cuñado Gil on 5/8/21.
//

import Foundation

protocol SplashProviderProtocol {
    func fetchData(completion: @escaping (EverGrouponServerModel) -> (), failure: @escaping (NetworkError) -> ())
}

class SplashProvider {
    
    let networkService: NetworkServiceProtocol = NetworkService()
}

extension SplashProvider: SplashProviderProtocol {
    func fetchData(completion: @escaping (EverGrouponServerModel) -> (), failure: @escaping (NetworkError) -> ()) {
        networkService.requestGeneric(dto: SplashProviderRequestDTO.requestDataList(),
                                      entityClass: EverGrouponServerModel.self) { [weak self] (result) in
            
            guard self != nil else { return }
            if let resultDes = result {
                completion(resultDes)
            }
            
        } failure: { [weak self] (error) in
            guard self != nil else { return }
            failure(error)
            
        }

    }
}

struct SplashProviderRequestDTO {
    static func requestDataList() -> RequestDTO {
        RequestDTO(param: nil, method: .get, endpoint: URLEndpoint.endpointGrouponList)
    }
}

//
//  AnnouncementViewModel.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import Foundation

class AnnouncementViewModel:ObservableObject{
    
    @Published var Annouces: [AnnouncementModel] = []
    @Published var Error: Bool = false

    func getAnnoucement(){
        Network.shared.apollo.fetch(query: GetAnnouncementQuery()){ [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let Annouces = graphQLResult.data?.getAnnouncement {
                    DispatchQueue.main.async {
                        self?.Annouces = Annouces.map(AnnouncementModel.init)
                    }
                }
            case .failure:
                self?.Error = true
            }
        }
    }
    
    func clearCache(){
        Network.shared.apollo.clearCache()
    }
    func resetAnnounce(){
        self.Annouces = []
    }
}

struct AnnouncementModel{
    let announce: GetAnnouncementQuery.Data.GetAnnouncement?
    
    var id: String{
        announce?._id ?? ""
    }
    var title: String{
        announce?.title ?? ""
    }
    var description: String{
        announce?.description ?? ""
    }
    var img: String{
        announce?.picture ?? ""
    }
    var date: String{
        announce?.date ?? ""
    }
}


//
//  Annoucements.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 27/8/22.
//

import SwiftUI

struct Annoucements: View {
    var prop: Properties
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State var showViewer: Bool = false
    @Binding var postId: String
    @StateObject var DetailAnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    
    var body: some View {
        ZStack{
                VStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .padding()
                            .font(.title)
                    }
                    .hTrailing()
                    if postId == ""{
                        Text("")
                    }else{
                        VStack{
                            ForEach(DetailAnnoucementList.Annouces, id: \.id){ Annouce in
                                if self.postId == Annouce.id {
                                    
                                    AsyncImage(url: URL(string: Annouce.img ), scale: 2){image in
                                        
                                        switch  image {
                                            
                                        case .empty:
                                            VStack{
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                                    .progressViewStyle(.circular)
                                                Text("សូមរង់ចាំ")
                                                    .foregroundColor(.blue)
                                            }
                                        case .success(let image):
                                            
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .cornerRadius(20)
                                                .padding()
                                                .frame(width: prop.size.width, height: prop.size.height,alignment:.top)
                                                .scaledToFit()
                                                .clipShape(Rectangle())
                                                .modifier(ImageModifier(contentSize: CGSize(width: prop.size.width, height: prop.size.height)))
                                                
                                        case .failure:
                                            Text("មិនអាចទាញទិន្ន័យបាន")
                                                .foregroundColor(.red)
                                                .hCenter()
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                    .frame( maxHeight: prop.isLandscape ? 400 : .infinity)
                                    
                                    ScrollView(.vertical, showsIndicators: false){
                                        Text(Annouce.title)
                                            .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                            .foregroundColor(.blue)
                                            .padding(.horizontal)
                                            .shadow(color: .white, radius: 5)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                        VStack{
                                            Text(Annouce.description)
                                        }
                                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                                        .foregroundColor(.blue)
                                        .padding(.horizontal)
                                        .shadow(color: .white, radius: 5)
                                        .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            .setBG()
            .onAppear{
                DetailAnnoucementList.getAnnoucement()
            }
        }
    }
}

struct Annoucements_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Annoucements(prop: prop, postId: .constant(""))
    }
}

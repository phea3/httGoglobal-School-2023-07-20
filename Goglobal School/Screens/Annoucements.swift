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
    @State var imgUrl: String = ""
    @Binding var postId: String
    var language: String
    @StateObject var DetailAnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.square.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                        .opacity(prop.isLandscape ? 1:0)
                }
                .hTrailing()
                if postId == ""{
                    Text("")
                }else{
                    VStack{
                        ForEach(DetailAnnoucementList.Annouces, id: \.id){ Annouce in
                            if self.postId == Annouce.id {
                                ScrollView(.vertical, showsIndicators: false){
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
                                            Button {
                                                self.showViewer = !showViewer
                                            } label: {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(20)
                                                    .padding()
                                                    .onAppear{
                                                        self.imgUrl = Annouce.img
                                                    }
                                            }
                                        case .failure:
                                            Text("មិនអាចទាញទិន្ន័យបាន")
                                                .foregroundColor(.red)
                                                .hCenter()
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                    .frame( maxHeight: prop.isLandscape ? 300 : prop.isiPad ? 400 : .infinity)
                                    
                                    
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
            if showViewer{
                ZStack{
                    Color("bgimg")
                        .frame(maxWidth:.infinity, maxHeight:.infinity)
                        .ignoresSafeArea()
                    AsyncImage(url: URL(string: imgUrl ), scale: 2){image in
                        
                        switch  image {
                            
                        case .empty:
                            VStack{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                    .progressViewStyle(.circular)
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .frame(width: prop.size.width, height: prop.size.height)
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
                    .frame(maxWidth:.infinity, maxHeight:.infinity)
                    Button {
                        self.showViewer = !showViewer
                    } label: {
                        Image(systemName: "xmark.square.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.topTrailing)
                }
            }
        }
    }
}

struct Annoucements_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Annoucements(prop: prop, postId: .constant(""), language: "em")
    }
}

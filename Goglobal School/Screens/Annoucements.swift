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
    @State var showImageViewer: Bool = true
    @State var imgURL: String = ""
    @State var showViewer: Bool = false
    @Binding var postId: String
    @StateObject var DetailAnnoucementList: AnnouncementViewModel = AnnouncementViewModel()
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .padding()
                            .font(.title)
                    }
                    .opacity(prop.isLandscape && prop.isiPhone ? 1:0)
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
                                                Text("សូមរងចាំ")
                                                    .foregroundColor(.blue)
                                            }
                                        case .success(let image):
                                            Button {
                                                self.showViewer = true
                                            } label: {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(20)
                                                    .padding()
                                                    .onAppear{
                                                        imgURL = Annouce.img
                                                    }
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        case .failure:
                                            Text("មិនអាចទាញទិន្ន័យបាន")
                                                .foregroundColor(.red)
                                                .hCenter()
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                    .frame( maxHeight: prop.isLandscape ? 400 : .infinity)
                                    VStack{
                                        Text(Annouce.title)
                                            .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .body))
                                            .foregroundColor(.blue)
                                            .padding(.horizontal)
                                            .shadow(color: .white, radius: 5)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                        Text(Annouce.description)
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .setBG()
            .onAppear{
                DetailAnnoucementList.getAnnoucement()
            }
            if showViewer{
                viewImage()
            }
        }
    }
    func viewImage()-> some View{
        GeometryReader { proxy in
            ZStack(alignment: .topTrailing){
                Color.black.opacity(0.5)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                AsyncImage(url: URL(string: imgURL)) { image in
                          image
                              .resizable()
                              .scaledToFit()
                              .clipShape(Rectangle())
                              .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                      } placeholder: {
                          Color.gray
                      }
                      .background(.clear)
                     
                Button {
                    self.showViewer = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .padding()
                        .font(.title)
                    }
                }
            }
        }
    }

struct Annoucements_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Annoucements(prop: prop, postId: .constant(""))
    }
}

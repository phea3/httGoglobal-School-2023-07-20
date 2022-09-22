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
                                            Text("""
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Feugiat nisl pretium fusce id velit ut. Risus nec feugiat in fermentum posuere urna nec tincidunt praesent. Sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum. Tortor posuere ac ut consequat semper viverra nam libero justo. Neque aliquam vestibulum morbi blandit cursus risus at ultrices mi. Dolor sit amet consectetur adipiscing. Ultricies integer quis auctor elit sed vulputate mi. Augue mauris augue neque gravida in fermentum et sollicitudin ac. Adipiscing commodo elit at imperdiet dui accumsan sit amet. Convallis convallis tellus id interdum velit. Purus viverra accumsan in nisl nisi scelerisque eu. Enim nec dui nunc mattis enim. Id consectetur purus ut faucibus pulvinar elementum integer. Molestie a iaculis at erat pellentesque adipiscing. Quam adipiscing vitae proin sagittis nisl rhoncus mattis.

                                                Feugiat nisl pretium fusce id. Sodales ut etiam sit amet. Arcu dui vivamus arcu felis bibendum ut. Ut ornare lectus sit amet est placerat in egestas. Tristique sollicitudin nibh sit amet. Vulputate ut pharetra sit amet aliquam id diam maecenas. Malesuada pellentesque elit eget gravida cum. Amet consectetur adipiscing elit ut aliquam purus sit amet luctus. Nisl pretium fusce id velit ut tortor pretium. Quis lectus nulla at volutpat diam ut. Quis ipsum suspendisse ultrices gravida dictum. At ultrices mi tempus imperdiet. Fringilla ut morbi tincidunt augue.

                                                Mi eget mauris pharetra et ultrices neque ornare. Odio facilisis mauris sit amet. Porta lorem mollis aliquam ut porttitor. Proin nibh nisl condimentum id. Commodo quis imperdiet massa tincidunt nunc. Faucibus purus in massa tempor. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas. Mi eget mauris pharetra et ultrices neque. Gravida rutrum quisque non tellus orci ac auctor augue. Id venenatis a condimentum vitae sapien pellentesque habitant morbi tristique. Risus pretium quam vulputate dignissim suspendisse in. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus. At urna condimentum mattis pellentesque id nibh tortor. Aenean et tortor at risus viverra adipiscing at in tellus. Neque aliquam vestibulum morbi blandit cursus. Tellus integer feugiat scelerisque varius.

                                                Sit amet luctus venenatis lectus. Congue nisi vitae suscipit tellus mauris a diam maecenas sed. Arcu risus quis varius quam quisque id diam vel quam. Neque convallis a cras semper auctor neque. Pharetra vel turpis nunc eget lorem dolor sed. Quam nulla porttitor massa id. Leo duis ut diam quam nulla. Massa sed elementum tempus egestas sed. Proin libero nunc consequat interdum varius sit amet mattis vulputate. Feugiat sed lectus vestibulum mattis ullamcorper velit sed. Faucibus ornare suspendisse sed nisi lacus sed viverra tellus in. Adipiscing elit pellentesque habitant morbi tristique senectus et. Purus semper eget duis at. Dolor sit amet consectetur adipiscing elit pellentesque habitant morbi tristique. Magna ac placerat vestibulum lectus mauris ultrices eros in cursus. Nibh tellus molestie nunc non. Massa eget egestas purus viverra.

                                                Aliquet sagittis id consectetur purus ut faucibus pulvinar elementum. Volutpat maecenas volutpat blandit aliquam etiam erat. Consequat ac felis donec et odio pellentesque diam volutpat commodo. Lacus sed turpis tincidunt id aliquet risus feugiat in ante. Ornare arcu odio ut sem nulla pharetra diam. Nam aliquam sem et tortor consequat id. Aliquet nec ullamcorper sit amet risus nullam eget. Neque convallis a cras semper auctor. At ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget. Adipiscing bibendum est ultricies integer. Arcu vitae elementum curabitur vitae. Sagittis eu volutpat odio facilisis mauris sit. Eget sit amet tellus cras adipiscing enim eu turpis egestas. Vitae ultricies leo integer malesuada nunc vel risus commodo viverra. Est sit amet facilisis magna etiam tempor orci eu. Placerat vestibulum lectus mauris ultrices eros in cursus turpis. Scelerisque eu ultrices vitae auctor eu. Magna eget est lorem ipsum. Lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis. In tellus integer feugiat scelerisque varius morbi enim.

                                                Aenean pharetra magna ac placerat vestibulum lectus mauris. Neque viverra justo nec ultrices dui. Sed vulputate odio ut enim blandit volutpat maecenas. Eros in cursus turpis massa tincidunt dui ut. Volutpat consequat mauris nunc congue nisi vitae. Nibh mauris cursus mattis molestie a iaculis at erat. Et malesuada fames ac turpis. Suspendisse interdum consectetur libero id faucibus nisl tincidunt eget nullam. Amet purus gravida quis blandit turpis cursus in hac. Et malesuada fames ac turpis egestas sed tempus urna et. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. In hac habitasse platea dictumst vestibulum rhoncus est pellentesque.

                                                Fusce id velit ut tortor pretium viverra. Blandit massa enim nec dui nunc. Et malesuada fames ac turpis egestas integer eget aliquet. Maecenas accumsan lacus vel facilisis volutpat. Pellentesque sit amet porttitor eget dolor. Fermentum odio eu feugiat pretium nibh. Cras fermentum odio eu feugiat pretium. Egestas diam in arcu cursus euismod quis viverra. Interdum velit laoreet id donec ultrices. A iaculis at erat pellentesque adipiscing commodo elit at imperdiet. Gravida neque convallis a cras semper.

                                                Duis at consectetur lorem donec massa sapien faucibus et molestie. Cras ornare arcu dui vivamus arcu felis. Nulla at volutpat diam ut venenatis tellus in. Accumsan in nisl nisi scelerisque. Integer malesuada nunc vel risus commodo viverra maecenas accumsan lacus. Placerat duis ultricies lacus sed. At in tellus integer feugiat scelerisque varius morbi. Egestas congue quisque egestas diam. Mi tempus imperdiet nulla malesuada pellentesque elit. Eget nullam non nisi est sit amet.

                                                Lectus urna duis convallis convallis tellus. Egestas integer eget aliquet nibh praesent tristique magna sit. Blandit turpis cursus in hac habitasse platea dictumst. Aliquam nulla facilisi cras fermentum. Sit amet consectetur adipiscing elit duis tristique sollicitudin. Consequat id porta nibh venenatis cras. Purus ut faucibus pulvinar elementum. Dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Auctor neque vitae tempus quam pellentesque nec nam aliquam sem. Bibendum neque egestas congue quisque egestas diam in arcu cursus. Enim nunc faucibus a pellentesque sit amet porttitor eget dolor. Eget dolor morbi non arcu risus quis varius quam. Mi quis hendrerit dolor magna eget. Porta non pulvinar neque laoreet suspendisse.

                                                Vel pretium lectus quam id leo in vitae turpis massa. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Sollicitudin aliquam ultrices sagittis orci a. Sed nisi lacus sed viverra tellus in hac habitasse. Aliquet bibendum enim facilisis gravida. Sed cras ornare arcu dui vivamus arcu felis. Tempus imperdiet nulla malesuada pellentesque elit eget gravida cum sociis. Duis convallis convallis tellus id interdum velit laoreet id. Elementum facilisis leo vel fringilla est ullamcorper eget nulla. Vitae sapien pellentesque habitant morbi tristique. Suspendisse ultrices gravida dictum fusce ut placerat orci nulla pellentesque. Senectus et netus et malesuada fames ac turpis egestas. Feugiat in ante metus dictum at. In arcu cursus euismod quis viverra nibh cras pulvinar.

                                                Pellentesque dignissim enim sit amet venenatis urna. Dolor magna eget est lorem ipsum dolor sit. Nisi est sit amet facilisis magna etiam tempor. Nunc sed augue lacus viverra vitae congue. Orci porta non pulvinar neque laoreet suspendisse interdum. Pharetra magna ac placerat vestibulum. Porttitor massa id neque aliquam vestibulum. At in tellus integer feugiat scelerisque varius morbi. Amet nulla facilisi morbi tempus iaculis urna id volutpat lacus. Eget nunc scelerisque viverra mauris. In tellus integer feugiat scelerisque varius morbi enim. Accumsan lacus vel facilisis volutpat est velit egestas. Tortor at auctor urna nunc id cursus.

                                                Integer vitae justo eget magna fermentum iaculis. Tortor pretium viverra suspendisse potenti nullam ac. Ac tortor dignissim convallis aenean et tortor at risus viverra. Etiam dignissim diam quis enim lobortis scelerisque. Sit amet consectetur adipiscing elit duis. Erat pellentesque adipiscing commodo elit at. Ultricies mi quis hendrerit dolor magna. Molestie ac feugiat sed lectus vestibulum mattis ullamcorper velit sed. Elementum curabitur vitae nunc sed velit dignissim sodales ut eu. Amet mauris commodo quis imperdiet massa tincidunt nunc pulvinar. Tellus integer feugiat scelerisque varius morbi enim. Placerat orci nulla pellentesque dignissim enim. Hendrerit gravida rutrum quisque non tellus. Curabitur vitae nunc sed velit.

                                                Volutpat blandit aliquam etiam erat. Ipsum nunc aliquet bibendum enim facilisis. Fringilla est ullamcorper eget nulla. Sollicitudin aliquam ultrices sagittis orci a scelerisque. Viverra aliquet eget sit amet tellus cras. Viverra ipsum nunc aliquet bibendum enim. Convallis convallis tellus id interdum velit. Urna neque viverra justo nec ultrices dui. Ac tortor dignissim convallis aenean et tortor at risus viverra. Donec enim diam vulputate ut. Blandit aliquam etiam erat velit scelerisque in. Nibh ipsum consequat nisl vel. Vitae semper quis lectus nulla. Nulla pellentesque dignissim enim sit. Tincidunt vitae semper quis lectus nulla at volutpat diam. Eget est lorem ipsum dolor sit amet consectetur adipiscing. Augue interdum velit euismod in pellentesque massa placerat duis ultricies. Elit ullamcorper dignissim cras tincidunt. Non quam lacus suspendisse faucibus interdum posuere. Massa tincidunt nunc pulvinar sapien.

                                                Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna. Vitae nunc sed velit dignissim sodales ut eu sem. Facilisis sed odio morbi quis commodo odio aenean sed. Cursus metus aliquam eleifend mi in nulla. Vulputate mi sit amet mauris commodo quis imperdiet. Quis varius quam quisque id diam. Libero justo laoreet sit amet cursus sit. Vel orci porta non pulvinar neque laoreet suspendisse. Diam in arcu cursus euismod quis viverra nibh. Semper risus in hendrerit gravida rutrum quisque non. Aliquam eleifend mi in nulla. Viverra ipsum nunc aliquet bibendum enim facilisis. Leo vel fringilla est ullamcorper. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae. Nec tincidunt praesent semper feugiat nibh sed pulvinar proin. Pellentesque nec nam aliquam sem et tortor consequat. Aliquam purus sit amet luctus.

                                                Et odio pellentesque diam volutpat commodo. Malesuada nunc vel risus commodo viverra maecenas accumsan. Lacinia quis vel eros donec. Suscipit adipiscing bibendum est ultricies integer quis. Nunc sed velit dignissim sodales ut. Tellus at urna condimentum mattis. Dolor purus non enim praesent elementum facilisis leo. Luctus venenatis lectus magna fringilla urna. Dui accumsan sit amet nulla. Id ornare arcu odio ut sem nulla. Hendrerit gravida rutrum quisque non tellus orci ac auctor. Nibh tellus molestie nunc non blandit massa enim nec dui. Nulla pharetra diam sit amet. Purus gravida quis blandit turpis cursus in hac habitasse. Sit amet venenatis urna cursus eget nunc scelerisque viverra mauris. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras.

                                                Iaculis urna id volutpat lacus laoreet non curabitur. Venenatis a condimentum vitae sapien pellentesque. Eu tincidunt tortor aliquam nulla facilisi cras. Gravida rutrum quisque non tellus orci ac auctor. Lacus viverra vitae congue eu. Pretium viverra suspendisse potenti nullam. Ac auctor augue mauris augue neque gravida in fermentum. In egestas erat imperdiet sed euismod nisi porta lorem. Et tortor consequat id porta nibh venenatis. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Neque ornare aenean euismod elementum nisi quis eleifend. Ornare quam viverra orci sagittis eu volutpat odio facilisis. Ridiculus mus mauris vitae ultricies leo integer malesuada nunc. In fermentum et sollicitudin ac orci phasellus egestas tellus rutrum. Iaculis eu non diam phasellus vestibulum lorem sed. Neque egestas congue quisque egestas diam in.

                                                Lectus quam id leo in vitae turpis massa sed elementum. Mattis vulputate enim nulla aliquet porttitor lacus luctus accumsan. Lectus vestibulum mattis ullamcorper velit. Nibh nisl condimentum id venenatis a condimentum vitae. A condimentum vitae sapien pellentesque habitant morbi tristique. Nibh mauris cursus mattis molestie. Dignissim diam quis enim lobortis scelerisque fermentum. Non consectetur a erat nam. Sed velit dignissim sodales ut eu sem integer vitae. Mattis nunc sed blandit libero volutpat sed cras ornare arcu. Tristique sollicitudin nibh sit amet. Eget arcu dictum varius duis at. Neque laoreet suspendisse interdum consectetur libero.

                                                Nunc scelerisque viverra mauris in aliquam sem fringilla. Amet luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Eget velit aliquet sagittis id. Tempus urna et pharetra pharetra massa massa ultricies. At risus viverra adipiscing at in tellus integer feugiat scelerisque. Mauris in aliquam sem fringilla. Interdum varius sit amet mattis vulputate enim. Commodo quis imperdiet massa tincidunt nunc. Habitant morbi tristique senectus et netus et. Sit amet venenatis urna cursus eget.

                                                Lacus viverra vitae congue eu consequat ac felis donec et. Adipiscing diam donec adipiscing tristique risus. Elit ut aliquam purus sit amet luctus venenatis. Facilisi morbi tempus iaculis urna id volutpat. Congue eu consequat ac felis donec et odio. Sit amet dictum sit amet justo donec enim diam vulputate. Semper eget duis at tellus at urna condimentum mattis pellentesque. Nisl purus in mollis nunc sed. Cras pulvinar mattis nunc sed blandit libero volutpat. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Viverra justo nec ultrices dui. Eget sit amet tellus cras adipiscing enim eu turpis. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget. Non diam phasellus vestibulum lorem sed risus ultricies tristique nulla. Eget egestas purus viverra accumsan in nisl nisi scelerisque. Cursus mattis molestie a iaculis at erat. Sem et tortor consequat id porta. Amet risus nullam eget felis eget nunc lobortis mattis. Sit amet mauris commodo quis imperdiet massa tincidunt. Quisque sagittis purus sit amet volutpat.

                                                Vitae proin sagittis nisl rhoncus mattis rhoncus. Enim neque volutpat ac tincidunt vitae semper quis. Id diam vel quam elementum pulvinar etiam. Condimentum id venenatis a condimentum vitae. Varius duis at consectetur lorem. Aliquam malesuada bibendum arcu vitae. Nisl rhoncus mattis rhoncus urna. Lectus mauris ultrices eros in cursus turpis. Neque volutpat ac tincidunt vitae semper. Massa tincidunt dui ut ornare lectus sit amet. Lorem ipsum dolor sit amet consectetur. Sagittis eu volutpat odio facilisis mauris. Varius quam quisque id diam vel quam elementum pulvinar. Lorem ipsum dolor sit amet consectetur. Feugiat vivamus at augue eget arcu.

                                                A erat nam at lectus. Varius quam quisque id diam. Morbi enim nunc faucibus a. Quam id leo in vitae turpis massa. Dictum non consectetur a erat nam. Senectus et netus et malesuada fames ac turpis egestas. Morbi tristique senectus et netus. Consequat semper viverra nam libero justo laoreet. Rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Eget magna fermentum iaculis eu. Consequat interdum varius sit amet. Ultricies leo integer malesuada nunc vel risus commodo viverra. Sed turpis tincidunt id aliquet risus feugiat in.

                                                Varius duis at consectetur lorem donec. Tortor dignissim convallis aenean et tortor at. Sem et tortor consequat id. Eu augue ut lectus arcu bibendum at varius. Faucibus nisl tincidunt eget nullam non nisi est sit amet. Consectetur libero id faucibus nisl tincidunt eget nullam non nisi. A lacus vestibulum sed arcu non odio euismod lacinia. Faucibus ornare suspendisse sed nisi. Eget egestas purus viverra accumsan in. Ut lectus arcu bibendum at varius. Mi in nulla posuere sollicitudin. Et ultrices neque ornare aenean euismod elementum nisi quis eleifend. At elementum eu facilisis sed odio. Ac tortor dignissim convallis aenean et tortor at. Rhoncus est pellentesque elit ullamcorper dignissim. Congue mauris rhoncus aenean vel. Amet venenatis urna cursus eget nunc scelerisque viverra mauris in. Facilisis magna etiam tempor orci eu lobortis. Quis enim lobortis scelerisque fermentum. Vitae tempus quam pellentesque nec.

                                                Blandit cursus risus at ultrices mi tempus. Tempus egestas sed sed risus. Urna nec tincidunt praesent semper feugiat nibh sed pulvinar. Euismod nisi porta lorem mollis. Sodales ut eu sem integer vitae justo. Dictum varius duis at consectetur lorem donec. Velit laoreet id donec ultrices tincidunt arcu non sodales. Arcu risus quis varius quam quisque. Tortor at auctor urna nunc id cursus. Viverra accumsan in nisl nisi scelerisque. Eget mi proin sed libero enim. Consequat mauris nunc congue nisi vitae. Fermentum posuere urna nec tincidunt praesent semper feugiat nibh. Suspendisse ultrices gravida dictum fusce ut placerat orci nulla. Aliquam malesuada bibendum arcu vitae elementum curabitur vitae. Turpis tincidunt id aliquet risus feugiat in ante metus. Gravida dictum fusce ut placerat orci. Egestas integer eget aliquet nibh praesent tristique magna. Id aliquet lectus proin nibh nisl. Suspendisse sed nisi lacus sed viverra tellus in.

                                                Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Cursus vitae congue mauris rhoncus aenean vel elit. Semper risus in hendrerit gravida rutrum quisque non. Facilisis gravida neque convallis a cras semper auctor. Duis tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Nec ultrices dui sapien eget mi proin sed libero enim. Phasellus faucibus scelerisque eleifend donec pretium vulputate sapien. Pellentesque sit amet porttitor eget dolor. Aliquam purus sit amet luctus venenatis. Velit scelerisque in dictum non consectetur. Nibh venenatis cras sed felis eget velit aliquet sagittis. Enim facilisis gravida neque convallis. Viverra orci sagittis eu volutpat odio facilisis mauris sit. Urna porttitor rhoncus dolor purus. Sed viverra ipsum nunc aliquet. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum. Fames ac turpis egestas sed tempus urna et pharetra. Velit egestas dui id ornare arcu odio ut sem.

                                                In hendrerit gravida rutrum quisque non. Commodo odio aenean sed adipiscing. In nisl nisi scelerisque eu ultrices vitae auctor eu. Consequat interdum varius sit amet mattis vulputate enim. Commodo ullamcorper a lacus vestibulum. Enim ut tellus elementum sagittis vitae et. Nunc vel risus commodo viverra maecenas accumsan lacus. Diam sollicitudin tempor id eu. Turpis egestas sed tempus urna et pharetra pharetra. Pharetra et ultrices neque ornare aenean euismod. Diam quam nulla porttitor massa id. Aliquet sagittis id consectetur purus ut faucibus. In iaculis nunc sed augue lacus viverra vitae congue.
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                """)
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

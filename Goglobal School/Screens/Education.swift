//
//  Education.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//

import SwiftUI

struct Education: View {
    
    @StateObject var students: ListStudentViewModel = ListStudentViewModel()
    @State var axcessPadding: CGFloat = 0
    @State var userProfileImg: String
    @State var refreshing: Bool  = false
    @State var confirm: Bool = false
    @State var viewLoading: Bool = false
    @State var hidingDivider: Bool = false
    @Binding var isLoading: Bool
    let gradient = Color("BG")
    var parentId: String
    var barTitle: String = "ឆ្នាំសិក្សា ២០២១~២០២២"
    var prop: Properties
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if students.AllStudents.isEmpty{
                    ZStack{
                        if viewLoading{
                            progressingView(prop: prop)
                        }else{
                            Text("មិនមានទិន្ន័យ!")
                                .foregroundColor(.blue)
                        }
                    }
                    .onAppear{
                        self.viewLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.viewLoading = false
                        }
                    }
                }else if students.Error{
                    Text("សូមព្យាយាមម្តងទៀត")
                        .foregroundColor(.blue)
                }else{
                    Divider()
                        .opacity(hidingDivider ? 0:1)
                    if !refreshing{
                        ScrollRefreshable(title: "កំពុងភ្ជាប់", tintColor: .blue) {
                            mainView()
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbarView(prop: prop, barTitle: barTitle, profileImg: userProfileImg)
                                .padding(.bottom, prop.isiPhoneS ? 65 : prop.isiPhoneM ? 75 : prop.isiPhoneL ? 85 : 100)
                                .padding(.horizontal, prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : prop.isiPhoneL ? 14 : 16)
                        }
                    }else{
                        Spacer()
                        progressingView(prop: prop)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear {
                students.StundentAmount(parentId: parentId)
            }
            .setBG()
        }
        .refreshable {
            do {
                students.clearCache()
                // Sleep for 2 seconds
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            } catch {}
            self.hidingDivider = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hidingDivider = false
            }
            refreshingView()
            students.StundentAmount(parentId: parentId)
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    func refreshingView(){
        self.refreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshing = false
        }
    }
    func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                
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
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .padding(prop.isiPhoneS ? 20 : prop.isiPhoneM ? 20 : prop.isiPhoneL ? 24 : 25)
                case .failure:
                    Image("student")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .padding()
                @unknown default:
                    fatalError()
                }
            }
            .frame(height: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
            
            HStack{
                Text(Lastname)
                Text(Firstname)
            }
            .padding(2)
            .font(.custom("kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16, relativeTo: .largeTitle))
            .frame(maxWidth: prop.isiPhoneS ? 100 : prop.isiPhoneM ? 110 : prop.isiPhoneL ? 120 : 130)
            .background(.blue)
            .cornerRadius(5)
            .padding(.bottom, 10)
        }
        .background(.clear)
        .foregroundColor(confirm ? .black : .white)
        .frame(width: prop.isiPhoneS ? 160 : prop.isiPhoneM ? 170 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 185 : prop.isiPhoneM ? 200 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
    @ViewBuilder
    private func mainView()-> some View{
        VStack(alignment: .leading, spacing: 0){
            Text("បុត្រធីតា")
                .foregroundColor(.blue)
                .font(.custom("Bayon", size: prop.isiPhoneS ? 20 : prop.isiPhoneM ? 22 : prop.isiPhoneL ? 24:26, relativeTo: .largeTitle))
                .hLeading()
                .padding()
                .background(.clear)
            ZStack {
                imageStuBG(prop: prop)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : 12){
                        ForEach(students.AllStudents,id: \.Id){ student in
                            NavigationLink(
                                destination: Grade(studentId: student.Id, userProfileImg: userProfileImg, Enrollment: student.Enrollments, Student: "\(student.Lastname) \(student.Firstname)", parentId: parentId, barTitle: barTitle,prop: prop),
                                label: {
                                    widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop)
                                }
                            )
                        }
                    }
                    .frame(width: (prop.isLandscape && (prop.isiPhone || prop.isiPad)) || prop.isiPad ? prop.size.width : .infinity)
                }
            }
            Divider()
            VStack{
                Text(prop.isiPhoneS ? "iphoneS" : "NO!")
                Text(prop.isiPhoneM ? "iphoneM" : "NO!")
                Text(prop.isiPhoneL ? "iphoneL" : "NO!")
                Text(prop.isLandscape ? "landscape": "NO!")
                Text(prop.isiPhone ? "iPhone" :"NO!")
                Text(prop.isiPad ? "ipad" : "NO!")
                Text(prop.isiPadMini ? "ipadmini" : "NO!")
                Text(prop.isiPadPro ? "ipadpro" : "NO!")
            }
            
        }
        
    }
}

struct Education_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0.0, height:  0.0))
        Education(userProfileImg: "", isLoading: .constant(false), parentId: "", prop: prop)
    }
}

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
    @State var imgLoading: Bool = false
    @State var userProfileImg: String
    @Binding var isLoading: Bool
    let gradient = Color("BG")
    var parentId: String
    var barTitle: String = "ឆ្នាំសិក្សា ២០២១~២០២២"
    var prop: Properties
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    if students.AllStudents.isEmpty{
                        progressingView(prop: prop)
                    }else{
                        VStack(spacing: 0){
                            Divider()
                            ScrollView(.vertical, showsIndicators: false) {
                                Text("បុត្រធិតា")
                                    .foregroundColor(.blue)
                                    .font(.custom("Bayon", size: prop.isiPhoneS ? 26 : prop.isiPhoneM ? 28 : 30, relativeTo: .largeTitle))
                                    .hLeading()
                                    .padding()
                                    .background(.clear)
                                ZStack {
                                    imageStuBG(width: 300)
                                    VStack(spacing: 0){
                                        ScrollView(.horizontal, showsIndicators: false){
                                            HStack(spacing: prop.isiPhoneS ? 8 : prop.isiPhoneM ? 10 : 12){
                                                ForEach(students.AllStudents,id: \.Id){ student in
                                                    NavigationLink(
                                                        destination: Grade(studentId: student.Id, userProfileImg: userProfileImg, Enrollment: student.Enrollments, parentId: parentId, barTitle: barTitle,prop: prop, Student: "\(student.Lastname) \(student.Firstname)"),
                                                        label: {
                                                            widgetStu(ImageStudent: student.profileImage, Firstname: student.Firstname, Lastname: student.Lastname, prop: prop)
                                                        }
                                                    )
                                                }
                                            }
                                        }
                                        .padding()
                                        Divider()
                                    }
                                }
                                Spacer()
                            }
                        }
                        .setBG()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarView(prop: prop, barTitle: barTitle, profileImg: userProfileImg)
                    }
                }
                if imgLoading{
                    ZStack{
                        Color("BG")
                            .ignoresSafeArea()
                        progressingView(prop: prop)
                    }
                }
            }
            .onAppear {
                students.StundentAmount(parentId: parentId)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
    func widgetStu(ImageStudent: String, Firstname: String, Lastname: String,prop:Properties) -> some View {
        
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(ImageStudent)"), scale: 2){image in
                
                switch  image {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            self.imgLoading = true
                        }
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .onAppear {
                            self.imgLoading = false
                        }
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
            .frame(height:  prop.isiPhoneS ? 130 : prop.isiPhoneM ? 150 : prop.isiPhoneL ? 170 : 180)
            
            HStack{
                Text(Lastname)
                Text(Firstname)
            }
            .padding(5)
            .font(.system(size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 :16))
            .frame(maxWidth: prop.isiPhoneS ? 100 : prop.isiPhoneM ? 110 : prop.isiPhoneL ? 120 : 130)
            .background(.blue)
            .cornerRadius(5)
            .padding(.bottom, 10)
        }
        .background(.clear)
        .foregroundColor(.white)
        .frame(width: prop.isiPhoneS ? 140 : prop.isiPhoneM ? 160 : prop.isiPhoneL ? 180 : 200, height: prop.isiPhoneS ? 160 : prop.isiPhoneM ? 180 : prop.isiPhoneL ? 220 : 220, alignment: .center)
        .addBorder(.orange,width: 1, cornerRadius: 20)
    }
}

struct Education_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0.0, height:  0.0))
        Education(userProfileImg: "", isLoading: .constant(false), parentId: "", prop: prop)
    }
}

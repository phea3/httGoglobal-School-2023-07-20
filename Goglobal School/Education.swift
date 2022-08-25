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
    let gradient = Color("BG")
    var parentId: String
    var barTitle: String = "ឆ្នាំសិក្សា ២០២១~២០២២"
    var prop: Properties
    var body: some View {
        NavigationView {
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
                                                    destination: Grade(Enrollment: student.Enrollments, parentId: parentId, barTitle: barTitle,prop: prop, Student: "\(student.Lastname) \(student.Firstname)"),
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
                    .toolbarView(prop: prop, barTitle: barTitle)
                }
            }
            .onAppear {
                students.StundentAmount(parentId: parentId)
            }
        }
        .phoneOnlyStackNavigationView()
        .padOnlyStackNavigationView()
    }
}

struct Education_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false, isSplit: false, size: CGSize(width:  0.0, height:  0.0))
        Education(parentId: "", prop: prop)
    }
}
